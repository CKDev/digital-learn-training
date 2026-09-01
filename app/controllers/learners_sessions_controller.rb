class LearnersSessionsController < ApplicationController
  skip_before_action :authenticate_user!

  ORGANIZATION_ROLES = %i[organization_admin trainer user].freeze

  def new
    learners_client = DigitalLearnOauthClient.dl_client(current_organization)
    redirect_to learners_client.auth_code.authorize_url(
      redirect_uri: oauth_callback_learners_sessions_url,
      scope: 'read write'
    )
  end

  def callback
    learners_client = DigitalLearnOauthClient.dl_client(current_organization)
    token = learners_client.auth_code.get_token(
      params[:code],
      redirect_uri: oauth_callback_learners_sessions_url
    )

    user_info = token.get('/api/v1/me').parsed # TODO: Update to learners site /me endpoint?
    subdomain = user_info['organization_subdomain']
    org_admin = user_info['is_org_admin']
    trainer = user_info['is_trainer'] # Requires the learners site /me endpoint to expose this field

    organization = Organization.find_by(subdomain: subdomain)
    raise OrganizationNotFoundError, "Organization not found for subdomain: #{subdomain}" if organization.blank?

    if organization.trainers_only? && !org_admin && !trainer
      redirect_to root_path, alert: 'Your account does not have access to training materials for this organization.'
      return
    end

    user = User.find_or_initialize_by(email: user_info['email'])
    user.provider = 'dl_sso'
    user.save!

    user.update!(admin: true) if org_admin && subdomain == 'www'
    assign_organization_role(user, organization, org_admin: org_admin, trainer: trainer)

    sign_in(user)

    if admin_signed_in?
      redirect_to admin_root_path
    else
      redirect_to root_path
    end
  end

  class OrganizationNotFoundError < StandardError
  end

  private

  # Every Learners Session sign-in records which organization the user belongs
  # to and in what capacity, regardless of that organization's trainers_only
  # setting, so access can be re-verified on every request afterward.
  def assign_organization_role(user, organization, org_admin:, trainer:)
    target_role = if org_admin
                    :organization_admin
                  elsif trainer
                    :trainer
                  else
                    :user
                  end

    (ORGANIZATION_ROLES - [target_role]).each { |role| user.remove_role(role, organization) }
    user.add_role(target_role, organization)
  end
end

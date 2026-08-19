class LearnersSessionsController < ApplicationController
  skip_before_action :authenticate_user!

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

    if organization.trainers_only && !org_admin && !trainer
      redirect_to root_path, alert: 'Your account does not have access to training materials for this organization.'
      return
    end

    user = User.find_or_initialize_by(email: user_info['email'])
    user.provider = 'dl_sso'
    user.save!

    if org_admin
      user.update!(admin: true) if subdomain == 'www'
      user.add_role(:organization_admin, organization)
    end

    sign_in(user)

    if admin_signed_in?
      redirect_to admin_root_path
    else
      redirect_to root_path
    end
  end

  class OrganizationNotFoundError < StandardError
  end
end

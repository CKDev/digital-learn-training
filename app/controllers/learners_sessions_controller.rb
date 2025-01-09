class LearnersSessionsController < ApplicationController
  def new
    learners_client = DigitalLearnOauthClient.dl_client(current_organization)
    redirect_to learners_client.auth_code.authorize_url(
      redirect_uri: oauth_callback_learners_sessions_url,
      scope: "read write"
    )
  end

  def callback
    learners_client = DigitalLearnOauthClient.dl_client(current_organization)
    token = learners_client.auth_code.get_token(
      params[:code],
      redirect_uri: oauth_callback_learners_sessions_url
    )

    user_info = token.get("/api/v1/me").parsed # TODO: Update to learners site /me endpoint?
    user = User.find_or_initialize_by(email: user_info["email"])
    user.provider = "dl_sso"
    user.save!
    subdomain = user_info["organization_subdomain"]
    org_admin = user_info["is_org_admin"]
    organization = Organization.find_by(subdomain: subdomain)
    raise OrganizationNotFoundError, "Organization not found for subdomain: #{subdomain}" if organization.blank?

    user.add_role(:organization_admin, organization) if org_admin
    sign_in(user)
    redirect_to admin_root_path
  end

  class OrganizationNotFoundError < StandardError
  end
end

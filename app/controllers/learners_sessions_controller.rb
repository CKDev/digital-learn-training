class LearnersSessionsController < ApplicationController
  def new
    learners_client = DigitalLearnOauthClient.dl_client("www")
    redirect_to learners_client.auth_code.authorize_url(
      redirect_uri: oauth_callback_learners_sessions_url,
      scope: "read write"
    )
  end

  def callback
    learners_client = DigitalLearnOauthClient.dl_client("www")
    token = learners_client.auth_code.get_token(
      params[:code],
      redirect_uri: oauth_callback_learners_sessions_url
    )

    user_info = token.get("/api/v1/me").parsed # TODO: Update to learners site /me endpoint?
    user = User.find_or_initialize_by(email: user_info["email"])
    user.provider = "dl_sso"
    user.admin = true
    user.save!
    # subdomain = user_info["organization_subdomain"]
    # organization = Organization.find_by(subdomain: subdomain)
    # raise OrganizationNotFoundError, "Organization not found for subdomain: #{subdomain}" if organization.blank?

    # user.update(organization: organization, admin: true)
    user.update(admin: true)
    sign_in(user)
    redirect_to admin_root_path
  end

  class OrganizationNotFoundError < StandardError
  end
end

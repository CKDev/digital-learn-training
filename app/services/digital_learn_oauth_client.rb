class DigitalLearnOauthClient
  def self.dl_client(organization)
    OAuth2::Client.new(
      Rails.application.credentials.dig(Rails.env.to_sym, :dl_sso, :client_id),
      Rails.application.credentials.dig(Rails.env.to_sym, :dl_sso, :client_secret),
      site: "http://#{SubdomainBuilder.new(organization).build_learners_subdomain}.#{Rails.application.config.learners_site_host}",
      authorize_url: '/oauth/authorize',
      token_url: '/oauth/token',
      scopes: 'read write'
    )
  end
end

class DigitalLearnOauthClient
  def self.dl_client(_subdomain)
    # TODO: use subdomain to generate subdomain specific url
    OAuth2::Client.new(
      Rails.application.credentials.dig(Rails.env.to_sym, :dl_sso, :client_id),
      Rails.application.credentials.dig(Rails.env.to_sym, :dl_sso, :client_secret),
      site: Rails.application.credentials.dig(Rails.env.to_sym, :dl_sso, :learners_url),
      authorize_url: "/oauth/authorize",
      token_url: "/oauth/token",
      scopes: "read write"
    )
  end
end

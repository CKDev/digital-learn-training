class SamlSessionsController < Devise::SamlSessionsController
  # A malformed SAMLResponse (bad base64, invalid/absent XML) makes ruby-saml
  # raise directly instead of failing validation, so it never reaches Devise's
  # normal invalid-auth handling. Treat it the same as any other rejected SSO
  # attempt rather than letting it bubble up as a 500.
  rescue_from REXML::ParseException, Nokogiri::XML::SyntaxError, OpenSSL::OpenSSLError, with: :handle_invalid_saml_response

  after_action :store_winning_strategy, only: :create

  private

  def handle_invalid_saml_response(exception)
    DeviseSamlAuthenticatable::Logger.send("Rejected malformed SAMLResponse: #{exception.class}: #{exception.message}")
    redirect_to (request.subdomains.last == 'att' ? att_login_path : new_user_session_path),
                alert: I18n.t('devise.failure.invalid', authentication_keys: 'email')
  end

  def store_winning_strategy
    warden.session(:user)[:strategy] = warden.winning_strategies[:user].class.name.demodulize.underscore.to_sym
  end
end

# Devise redirects already signed-in users away from sign-in, password, and
# invitation actions. For JSON requests, respond with JSON instead so the
# frontend can handle it rather than following the redirect.
module JsonRequireNoAuthentication
  extend ActiveSupport::Concern

  private

  def require_no_authentication
    return super unless request.format.json?

    assert_is_devise_resource!
    no_input = devise_mapping.no_input_strategies

    authenticated = if no_input.present?
                      warden.authenticate?(*no_input, scope: resource_name)
                    else
                      warden.authenticated?(resource_name)
                    end

    if authenticated && (resource = warden.user(resource_name))
      render json: { error: I18n.t('devise.failure.already_authenticated'), redirectPath: after_sign_in_path_for(resource) },
             status: :forbidden
    end
  end
end

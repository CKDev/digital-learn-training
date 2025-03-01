class CustomFailure < Devise::FailureApp
  def redirect_url
    attempted_path = request.env['warden.options'][:attempted_path]

    # TODO: Get org from subdomain, check org auth requirement settings

    # This should only redirect non-admin att users to att login
    if request.subdomains.last == 'att' && !attempted_path.starts_with?('/admin')
      att_login_path
    else
      super
    end
  end

  # You need to override respond to eliminate recall
  def respond
    if http_auth?
      http_auth
    else
      redirect
    end
  end
end

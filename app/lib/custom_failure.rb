class CustomFailure < Devise::FailureApp
  # You need to override respond to eliminate recall
  def respond
    if http_auth?
      http_auth
    else
      redirect
    end
  end

  # JSON is a navigational format in the Devise config, which would otherwise
  # redirect JSON requests to the sign-in page instead of returning a 401
  def http_auth?
    request.format.json? || super
  end
end

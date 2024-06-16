class SessionsController < Devise::SessionsController
  layout "application"

  def destroy
    # Reset the warning dismissal
    session[:dismissed_collaborator_warning] = nil
    super
  end
end

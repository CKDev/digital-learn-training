class SessionsController < Devise::SessionsController
  layout "application"

  def new
    @admin_attempt = params[:admin] == true
    super
  end

  def destroy
    # Reset the warning dismissal
    session[:dismissed_collaborator_warning] = nil
    super
  end
end

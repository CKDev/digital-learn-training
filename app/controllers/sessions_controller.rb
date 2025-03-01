class SessionsController < Devise::SessionsController
  layout 'application'

  respond_to :html, :json
  protect_from_forgery with: :null_session, if: -> { request.format.json? }

  def new
    @admin_attempt = params[:admin] == true
    super
  end

  def create
    if request.format.json?
      self.resource = warden.authenticate(scope: resource_name)
      if resource
        sign_in(resource_name, resource)
        render json: { message: 'Signed in successfully', user: resource, redirectPath: after_sign_in_path_for(resource) }, status: :ok
      else
        render json: { error: 'Invalid email or password' }, status: :unauthorized
      end
    else
      super
    end
  end

  def destroy
    # Reset the warning dismissal
    session[:dismissed_collaborator_warning] = nil

    if request.format.json?
      signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
      if signed_out
        render json: { message: 'Signed out successfully.' }, status: :ok
      else
        render json: { error: 'Could not sign out' }, status: :unprocessable_entity
      end
    else
      super
    end
  end
end

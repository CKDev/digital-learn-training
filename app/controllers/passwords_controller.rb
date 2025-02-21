class PasswordsController < Devise::PasswordsController
  before_action :fix_admin_layout

  respond_to :html, :json
  protect_from_forgery with: :null_session, if: -> { request.format.json? }

  def create
    if request.format.json?
      self.resource = resource_class.send_reset_password_instructions(resource_params)
      if resource
        render json: { message: I18n.t('devise.passwords.send_instructions'), redirectPath: after_sending_reset_password_instructions_path_for(resource_name) }, status: :ok
      else
        render json: { error: resource.errors.full_messages.join(', ') }, status: :unauthorized
      end
    else
      super
    end
  end

  def update
    if request.format.json?
      self.resource = resource_class.reset_password_by_token(resource_params)
  
      if resource.errors.empty?
        resource.unlock_access! if unlockable?(resource)
        if resource_class.sign_in_after_reset_password
          resource.after_database_authentication
          sign_in(resource_name, resource)
          render json: { message: 'Password reset successfully', redirectPath: after_sign_in_path_for(resource) }, status: :ok
        else
          render json: { message: 'Password reset successfully' }, status: :ok
        end
      else
        render json: { message: resource.errors.full_messages.join(', ') }, status: :unprocessable_entity
      end
    else
      super
    end
  end

  private

  def fix_admin_layout
    if user_signed_in? && current_user.admin?
      @include_admin_sidebar = true
      @use_ui_v2 = false
    end
  end
end

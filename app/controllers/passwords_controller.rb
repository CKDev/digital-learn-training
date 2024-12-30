class PasswordsController < Devise::PasswordsController
  layout proc { user_signed_in? ? "admin/base" : "application" }

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
end

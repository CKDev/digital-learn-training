class RegistrationsController < Devise::RegistrationsController
  respond_to :html, :json
  protect_from_forgery with: :null_session, if: -> { request.format.json? }

  def edit
    @include_admin_sidebar = current_user&.admin?
  end

  def update
    if request.format.json?
      self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
      prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

      resource_updated = update_resource(resource, account_update_params)
      if resource_updated
        bypass_sign_in resource, scope: resource_name if sign_in_after_change_password?
        response_message = get_message_for_update(resource, prev_unconfirmed_email)
        render json: { message: response_message }, status: :ok
      else
        render json: { message: resource.errors.full_messages.join(", ") }, status: :unprocessable_entity
      end
    else
      super
    end
  end

  private

  def get_message_for_update(resource, prev_unconfirmed_email)
    message_key = if update_needs_confirmation?(resource, prev_unconfirmed_email)
                    :update_needs_confirmation
                  elsif sign_in_after_change_password?
                    :updated
                  else
                    :updated_but_not_signed_in
                  end

    find_message(message_key)
  end
end

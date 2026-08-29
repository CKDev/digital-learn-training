class InvitationsController < Devise::InvitationsController
  before_action :configure_update_params, only: :update

  respond_to :html, :json
  protect_from_forgery with: :null_session, if: -> { request.format.json? }

  def new
    access_request_id = params[:access_request_id]
    if access_request_id.present?
      access_request = AccessRequest.find(access_request_id)
      self.resource = resource_class.new(email: access_request.email)
    else
      self.resource = resource_class.new
    end
    render :new
  end

  def create
    if request.format.json?
      self.resource = invite_resource

      if resource.errors.empty?
        render json: { message: I18n.t('devise.invitations.send_instructions', email: resource.email), redirectPath: after_invite_path_for(current_inviter, resource) }, status: :ok
      else
        render json: { error: resource.errors.full_messages.join(', ') }, status: :unprocessable_entity
      end
    else
      super
    end
  end

  def edit
    access_request = AccessRequest.find_by(email: resource.email)
    collaborator_profile = resource.build_collaborator_profile

    if access_request.present?
      collaborator_profile.assign_attributes(
        first_name: access_request.full_name.split(' ', 2).first,
        last_name: access_request.full_name.split(' ', 2).last,
        phone: access_request.phone,
        organization_name: access_request.organization_name,
        poc_name: access_request.poc_name,
        poc_email: access_request.poc_email
      )
    end

    super
  end

  def update
    if request.format.json?
      self.resource = accept_resource
      verify_recaptcha(model: resource)

      if resource.errors.empty?
        resource.unlock_access! if unlockable?(resource)
        resource.after_database_authentication
        sign_in(resource_name, resource)
        render json: { message: I18n.t('devise.invitations.updated'), redirectPath: after_accept_path_for(resource) }, status: :ok
      else
        render json: { error: resource.errors.full_messages.join(', ') }, status: :unprocessable_entity
      end
    else
      super do |user|
        verify_recaptcha(model: user)
        resource.errors.empty?
      end
    end
  end

  protected

  def configure_update_params
    update_keys = [
      :password,
      :password_confirmation,
      :invitation_token,
      { collaborator_profile_attributes: %i[
        first_name
        last_name
        phone
        organization_name
        organization_city
        organization_state
        poc_name
        poc_email
        terms_of_service
      ] }
    ]
    devise_parameter_sanitizer.permit(:accept_invitation, keys: update_keys)
  end
end

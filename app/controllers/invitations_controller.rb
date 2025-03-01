class InvitationsController < Devise::InvitationsController
  before_action :configure_update_params, only: :update

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
    super do |user|
      verify_recaptcha(model: user)
      resource.errors.empty?
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

class InvitationsController < Devise::InvitationsController
  layout "admin/base", only: [:new, :create]

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

  def update
    # TODO: Verify CAPTCHA
    # TODO: Create collaborator profile
    super
  end
end
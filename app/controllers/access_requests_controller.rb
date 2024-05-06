class AccessRequestsController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @access_request = AccessRequest.new
  end

  def create
    @access_request = AccessRequest.new(access_request_params.merge(organization: current_organization))

    if @access_request.save
      flash[:notice] = 'Your request for access has been submitted. If approved, you will receive an email invitation to set up your account.'
      redirect_to new_user_session_path
    else
      render :new
    end
  end

  private

  def access_request_params
    params
      .require(:access_request)
      .permit(:full_name,
              :organization_name,
              :email,
              :phone,
              :poc_name,
              :poc_email,
              :request_reason)
  end
end

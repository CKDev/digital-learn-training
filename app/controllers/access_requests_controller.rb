class AccessRequestsController < ApplicationController
  skip_before_action :authenticate_user!

  respond_to :html, :json
  protect_from_forgery with: :null_session, if: -> { request.format.json? }

  def new
    @access_request = AccessRequest.new
  end

  def create
    @access_request = AccessRequest.new(access_request_params.merge(organization: current_organization))

    if verify_recaptcha(model: @access_request) && @access_request.save
      message = 'Your request for access has been submitted. If approved, you will receive an email invitation to set up your account.'
      if request.format.json?
        render json: { message: message, redirectPath: new_user_session_path }, status: :ok
      else
        flash[:notice] = message
        redirect_to new_user_session_path
      end
    else
      if request.format.json?
        render json: { error: @access_request.errors.full_messages.join(', ') }, status: :unprocessable_entity
      else
        flash[:alert] = @access_request.errors.full_messages.join(', ')
        render :new
      end
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

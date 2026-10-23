class ErrorsController < ApplicationController
  # Error pages are rendered by exceptions_app outside the Warden middleware,
  # where an authentication failure would turn into an uncaught 500
  skip_before_action :authenticate_user!
  skip_before_action :enforce_trainers_only_access!
  def error_404
    render status: :not_found
  end

  def error_422
    render status: :unprocessable_entity
  end

  def error_500
    render status: :internal_server_error
  end
end

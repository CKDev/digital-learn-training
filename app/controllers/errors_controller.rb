class ErrorsController < ApplicationController
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

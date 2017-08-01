module Admin
  class BaseController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin!

    def authorize_admin!
      unless current_user.admin?
        flash[:alert] = "Access denied."
        redirect_to root_path
      end
    end
  end
end

module Admin
  class BaseController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin!
    before_action :enable_admin_sidebar
    before_action :unset_ui_v2

    def authorize_admin!
      unless current_user.admin?
        flash[:alert] = "You are not authorized to view this page."
        redirect_to root_path
      end
    end

    private

    def enable_admin_sidebar
      @include_admin_sidebar = true
    end

    def unset_ui_v2
      @use_ui_v2 = false
    end
  end
end

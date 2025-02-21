module Admin
  class BaseController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin!
    before_action :enable_admin_sidebar

    def authorize_admin!
      unless current_user.admin? || current_user.has_role?(:organization_admin, current_organization)
        flash[:alert] = "You are not authorized to view this page."
        redirect_to root_path
      end
    end

    private

    def enable_admin_sidebar
      @include_admin_sidebar = true
    end
  end
end

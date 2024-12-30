class RegistrationsController < Devise::RegistrationsController
  before_action :fix_admin_layout

  private

  def fix_admin_layout
    if user_signed_in? && current_user.admin?
      @include_admin_sidebar = true
      @use_ui_v2 = false
    end
  end
end

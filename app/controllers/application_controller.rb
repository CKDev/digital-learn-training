class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_blank_templates
  before_action :set_footer_links
  helper_method :admin_signed_in?

  def admin_signed_in?
    user_signed_in? && current_user.admin?
  end

  private

  def set_blank_templates
    @blank_template = CourseMaterial.find_by(title: "Course Templates")
  end

  def set_footer_links
    @footer_links = Page.published.alpha_order
  end
end

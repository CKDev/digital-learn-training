class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  layout :set_layout

  before_action :current_organization # Set current organization instance var
  before_action :set_blank_templates
  before_action :set_footer_links
  before_action :set_ui_v2

  before_action :authenticate_user!, if: :authentication_required?

  helper_method :admin_signed_in?
  helper_method :current_organization
  helper_method :current_language
  helper_method :current_language_name

  def admin_signed_in?
    user_signed_in? && (current_user.admin? || current_user.has_role?(:organization_admin, current_organization))
  end

  def after_sign_in_path_for(user)
    if user.admin?
      admin_root_path
    elsif user.collaborator?
      root_path(user, login_warning: true)
    else
      stored_location_for(user) || signed_in_root_path(user)
    end
  end

  def after_sign_out_path_for(_resource)
    if authenticated_with_saml?
      destroy_saml_user_session_path
    else
      root_path
    end
  end

  def after_invite_path_for(_inviter, _invitee)
    admin_root_path
  end

  protected

  def authenticate_inviter!
    # Limit invitations to admins only
    unless current_user.present? && current_user.admin?
      flash[:alert] = "You are not authorized to view this page"
      redirect_to admin_root_path
    end

    current_user
  end

  private

  def current_organization
    if request.subdomains.last == "training"
      subdomain = request.subdomains.first
    else
      # Legacy subdomain handling (AT&T)
      subdomain = request.subdomains.last
    end

    @current_organization ||= Organization.find_by(subdomain: subdomain)
  end

  def set_layout
    organization = current_organization
    return "application" if organization.blank?

    custom_org_layout_file = Rails.root.join "app", "views", "layouts", "#{organization.subdomain}.html.erb"
    if File.exist? custom_org_layout_file
      current_organization.subdomain # Use subomain as layout file name
    else
      "application"
    end
  end

  def include_user_sidebar
    @include_user_sidebar = true
  end

  def set_blank_templates
    @blank_template = CourseMaterial.find_by(title: "Course Templates")
  end

  def set_footer_links
    @footer_links = Page.published.alpha_order
  end

  def authenticated_with_saml?
    warden.session(:user)[:strategy] == :saml_authenticatable
  rescue Warden::NotAuthenticated
    false
  end

  def authentication_required?
    current_organization&.authentication_required
  end

  def current_language
    session[:locale] || "en"
  end

  def current_language_name
    case current_language
    when "es" then "Spanish"
    when "en" then "English"
    end
  end

  def set_ui_v2
    @use_ui_v2 = current_organization&.subdomain != "att" # Use legacy UI for att subdomain
  end
end

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :current_organization
  before_action :set_blank_templates
  before_action :set_footer_links

  before_action :authenticate_user!, if: :organization_subdomain?

  helper_method :admin_signed_in?
  helper_method :current_organization
  helper_method :current_language
  helper_method :current_language_name

  def admin_signed_in?
    user_signed_in? && current_user.admin?
  end

  def after_sign_in_path_for(user)
    if user.collaborator?
      root_path(user, login_warning: true)
    else
      stored_location_for(user) || signed_in_root_path(user)
    end
  end

  def after_sign_out_path_for(resource)
    if authenticated_with_saml?
      destroy_saml_user_session_path
    else
      root_path
    end
  end

  def after_invite_path_for(inviter, invitee)
    admin_root_path
  end

  protected

  def authenticate_inviter!
    # Limit invitations to admins only
    unless current_user.present? && current_user.admin?
      flash[:alert] = "You are not authorized to view this page"
      redirect_to admin_root_path
    end

    return current_user
  end

  private

  def current_organization
    @current_organization ||= Organization.find_by(subdomain: request.subdomains.last)
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

  def organization_subdomain?
    current_organization.present?
  end

  def current_language
    session[:locale] || 'en'
  end

  def current_language_name
    case current_language
    when 'es' then 'Spanish'
    when 'en' then 'English'
    end
  end
end

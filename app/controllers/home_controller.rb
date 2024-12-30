class HomeController < ApplicationController
  prepend_before_action :redirect_unauthenticated_subdomain_user, only: :index
  skip_before_action :authenticate_user!, only: :language_toggle
  before_action :include_user_sidebar

  def index
    set_locale

    if @use_ui_v2
      redirect_to course_materials_path, notice: params[:flash_message]
    end

    @courses = Course.published.limit(2)
    @categories = get_categories
    @getting_started = @categories.where(tag: "Getting Started")
    @hardware = @categories.where(tag: "Hardware")
    @software_and_applications = @categories.where(tag: "Software & Applications")
    @job_and_career = @categories.where(tag: "Job & Career")
  end

  def language_toggle
    set_locale
    redirect_back(fallback_location: root_path)
  end

  private

  def get_categories
    categories = current_organization ? Category.where(organization: current_organization) : Category.where(organization: nil)

    categories.includes(sub_categories: :course_materials)
  end

  def redirect_unauthenticated_subdomain_user
    if !current_user && current_organization
      redirect_to "/#{current_organization.subdomain}/login"
    end
  end

  def set_locale
    requested_locale = params["lang"]
    whitelisted_locales = %w[en es]
    session[:locale] = requested_locale if whitelisted_locales.include?(requested_locale)
  end
end

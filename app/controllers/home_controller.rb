class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: :language_toggle
  before_action :include_user_sidebar

  def index
    set_locale
    redirect_to course_materials_path, notice: params[:flash_message]
  end

  def language_toggle
    set_locale
    redirect_back(fallback_location: root_path)
  end

  private

  def set_locale
    requested_locale = params['lang']
    whitelisted_locales = %w[en es]
    session[:locale] = requested_locale if whitelisted_locales.include?(requested_locale)
  end
end

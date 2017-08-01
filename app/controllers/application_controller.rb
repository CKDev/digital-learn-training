class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_footer_links

  private

  def set_footer_links
    # TODO: good candidate for caching
    @footer_links = Page.published.alpha_order
  end
end

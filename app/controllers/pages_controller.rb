class PagesController < ApplicationController
  before_action :find_page

  def show
    @page_body = @page.body.html_safe
  end

  def find_page
    if user_signed_in? && current_user.admin?
      @page = Page.friendly.find(params[:id])
    else
      @page = Page.published.friendly.find(params[:id])
    end
    redirect_to @page, status: :moved_permanently if request.path != page_path(@page)
  end
end

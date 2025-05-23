module Admin
  class PagesController < BaseController

    before_action :set_page, only: %i[edit update]
    before_action :set_legacy_ui

    def index
      @pages = Page.not_archived.alpha_order
    end

    def new
      @page = Page.new
    end

    def edit
    end

    def create
      @page = Page.new(page_params)
      if @page.save
        flash[:notice] = 'Successfully created page'
        redirect_to admin_pages_path
      else
        render :new
      end
    end

    def update
      @page.slug = nil if @page.title != params[:page][:title] # Force regenerate if title changes.
      if @page.update(page_params)
        flash[:notice] = 'Successfully updated page'
        redirect_to admin_pages_path
      else
        render :edit
      end
    end

    private

    def page_params
      params.require(:page).permit(:title, :body, :author, :pub_status, :seo_title, :meta_desc)
    end

    def set_page
      @page = Page.friendly.find(params[:id])
    end

    def set_legacy_ui
      @legacy_page = true
    end
  end
end

module Admin
  class PagesController < BaseController

    before_action :set_page, only: [:edit, :update]

    def index
      @pages = Page.all.alpha_order
    end

    def new
      @page = Page.new
    end

    def create
      @page = Page.new(page_params)
      if @page.save
        flash[:notice] = "Successfully created page"
        redirect_to admin_pages_path
      else
        render :new
      end
    end

    def edit
    end

    def update
      if @page.update(page_params)
        flash[:notice] = "Successfully updated page"
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

  end
end

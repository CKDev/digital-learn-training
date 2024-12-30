module Admin
  class CategoriesController < BaseController
    def index
      @categories = Category.order(:title)
    end

    def new
      @category = Category.new
      @category.sub_categories.build
    end

    def edit
      @category = Category.friendly.find(params[:id])
    end

    def create
      @category = Category.new
      if @category.update(category_params)
        redirect_to admin_categories_path, notice: "Successfully created new category"
      else
        render :new
      end
    end

    def update
      @category = Category.friendly.find(params[:id])
      if @category.update(category_params)
        redirect_to admin_categories_path, notice: "Successfully updated category"
      else
        render :edit
      end
    end

    private

    def category_params
      params.require(:category).permit(:title, :description, :organization_id, :tag, sub_categories_attributes: %i[id title _destroy])
    end

  end
end

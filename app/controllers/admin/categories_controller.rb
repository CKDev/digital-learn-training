module Admin
  class CategoriesController < BaseController
    def index
      @categories = Category.where(organization: current_organization).order(:title)
    end

    def new
      @category = Category.new
      @category.sub_categories.build
    end

    def edit
      @category = Category.friendly.find(params[:id])
    end

    def create
      @category = Category.new(organization: current_organization)

      respond_to do |format|
        format.json do
          if @category.update(category_params)
            render json: { message: "Category created successfully" }, status: :created
          else
            render json: { error: @category.errors.full_messages.join(", ") }, status: :unprocessable_entity
          end
        end
        format.html do
          if @category.update(category_params)
            redirect_to admin_categories_path, notice: "Category created successfully"
          else
            render :new
          end
        end
      end
    end

    def update
      @category = Category.friendly.find(params[:id])

      respond_to do |format|
        format.json do
          if @category.update(category_params)
            render json: { message: "Category updated successfully" }, status: :created
          else
            render json: { error: @category.errors.full_messages.join(", ") }, status: :unprocessable_entity
          end
        end
        format.html do
          if @category.update(category_params)
            redirect_to admin_categories_path, notice: "Category updated successfully"
          else
            render :edit
          end
        end
      end

    end

    private

    def category_params
      params.require(:category).permit(:title, :description, :organization_id, :tag, sub_categories_attributes: %i[id title _destroy])
    end

  end
end

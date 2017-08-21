module Admin
  class CourseMaterialsController < BaseController

    def index
      @course_materials = CourseMaterial.all
    end

    def new
      @course_material = CourseMaterial.new
      @course_material.course_material_files.build
      @course_material.course_material_medias.build
      @sub_categories = []
      if request.xhr? # Ajax call for dynamic select box
        @sub_categories = Category.find(params[:category_id]).sub_categories
      end
    end

    def create
      @course_material = CourseMaterial.new
      if @course_material.update(course_material_params)
        redirect_to admin_course_materials_path, notice: "Successfully created new Course Materials"
      else
        render :new
      end
    end

    def edit
      @course_material = CourseMaterial.find(params[:id])
      if request.xhr? # Ajax call for dynamic select box
        if params[:category_id].present?
          category = Category.find(params[:category_id])
          @sub_categories = category.sub_categories
        else
          @sub_categories = []
        end
      else
        if @course_material.sub_category.present?
          @sub_categories = @course_material.sub_category.category.sub_categories # TODO: could be better.
        else
          @sub_categories = []
        end
      end
    end

    def update
      @course_material = CourseMaterial.find(params[:id])
      if @course_material.update(course_material_params)
        redirect_to admin_course_materials_path, notice: "Successfully updated Course Materials"
      else
        if @course_material.sub_category.present?
          @sub_categories = @course_material.sub_category.category.sub_categories # TODO: could be better.
        else
          @sub_categories = []
        end
        render :edit
      end
    end

    private

    def course_material_params
      params.require(:course_material).permit(:title, :contributor, :summary, :description,
        :category_id, :sub_category_id,
        course_material_files_attributes: [:id, :file, :_destroy],
        course_material_medias_attributes: [:id, :media, :_destroy])
    end

  end
end

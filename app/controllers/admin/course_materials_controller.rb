module Admin
  class CourseMaterialsController < BaseController

    def index
      @course_materials = CourseMaterial.all
    end

    def new
      @course_material = CourseMaterial.new
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
    end

    def update
      @course_material = CourseMaterial.find(params[:id])
      if @course_material.update(course_material_params)
        redirect_to admin_course_materials_path, notice: "Successfully updated Course Materials"
      else
        render :edit
      end
    end

    private

    def course_material_params
      params.require(:course_material).permit(:title, :contributor, :summary, :description)
    end

  end
end

module Admin
  class CourseMaterialsController < BaseController

    def index
      @course_materials = CourseMaterial.not_archived.order(:title)
    end

    def new
      @course_material = CourseMaterial.new
      @course_material.course_material_files.build
      @course_material.course_material_medias.build
      @course_material.course_material_videos.build
    end

    def create
      @course_material = CourseMaterial.new
      if @course_material.update(course_material_params)
        redirect_to admin_course_materials_path, notice: "Successfully created new Course"
      else
        render :new
      end
    end

    def edit
      @course_material = CourseMaterial.find(params[:id])
      @readonly = @course_material.title.in? PROTECTED_COURSE_MATERIALS
    end

    def update
      @course_material = CourseMaterial.find(params[:id])
      if @course_material.update(course_material_params)
        redirect_to admin_course_materials_path, notice: "Successfully updated Course"
      else
        render :edit
      end
    end

    private

    def course_material_params
      params.require(:course_material).permit(:title, :contributor, :summary, :description,
        :category_id, :sub_category_id, :pub_status,
        course_material_files_attributes: [:id, :file, :_destroy],
        course_material_medias_attributes: [:id, :media, :_destroy],
        course_material_videos_attributes: [:id, :url, :_destroy])
    end

  end
end
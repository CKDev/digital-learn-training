module Admin
  class CourseMaterialsController < BaseController

    helper_method :categories_array

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
      @course_material.sort_order = CourseMaterial.count + 1
      if @course_material.update(course_material_params)
        redirect_to admin_course_materials_path, notice: "Successfully created new Course"
      else
        render :new
      end
    end

    def edit
      @course_material = CourseMaterial.friendly.find(params[:id])
      @readonly = @course_material.title.in? PROTECTED_COURSE_MATERIALS
    end

    def update
      @course_material = CourseMaterial.friendly.find(params[:id])
      if @course_material.update(course_material_params)
        redirect_to admin_course_materials_path, notice: "Successfully updated Course"
      else
        render :edit
      end
    end

    def sort
      params[:order].each { |_k, v| CourseMaterial.find(v[:id]).update(sort_order: v[:position]) }
      respond_to do |format|
        format.json { render json: true, status: :ok }
      end
    end

    private

    def course_material_params
      params[:course_material][:sub_category_id] = "" if params[:course_material][:sub_category_id].blank? # Remove if not passed in.
      params.require(:course_material).permit(
        :title,
        :contributor,
        :summary,
        :description,
        :sort_order,
        :category_id,
        :sub_category_id,
        :pub_status,
        :language,
        :new_course,
        course_material_files_attributes: [:id, :file, :_destroy],
        course_material_medias_attributes: [:id, :media, :_destroy],
        course_material_videos_attributes: [:id, :url, :_destroy])
    end

    def categories_array
      Category.order(:title).map do |c|
        category_title = c.organization.present? ? "#{c.title} (#{c.organization.title})" : c.title
        [category_title, c.id]
      end
    end

  end
end

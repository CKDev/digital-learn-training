module Admin
  class CourseMaterialsController < BaseController
    helper_method :categories_array

    def index
      @course_materials = CourseMaterial.for_organization(current_organization).not_archived.order(:sort_order)
    end

    def new
      if current_organization && current_organization.categories.empty?
        flash[:alert] = "You must create at least one category before you can create a Course"
        redirect_to admin_categories_path and return
      end

      @course_material = CourseMaterial.new
      @categories = Category.where(organization: current_organization).order(:title)
      @course_material.course_material_files.build
      @course_material.course_material_medias.build
      @course_material.course_material_videos.build
    end

    def edit
      @course_material = CourseMaterial.friendly.find(params[:id])
      @categories = Category.where(organization: current_organization).order(:title)
      @readonly = @course_material.title.in? PROTECTED_COURSE_MATERIALS
    end

    def create
      @course_material = CourseMaterial.new
      @course_material.sort_order = CourseMaterial.count + 1

      respond_to do |format|
        format.json do
          if @course_material.update(course_material_params)
            render json: { message: "Course created successfully", course_material_id: @course_material.id }, status: :created
          else
            render json: { error: @course_material.errors.full_messages.join(", ") }, status: :unprocessable_entity
          end
        end

        format.html do
          if @course_material.update(course_material_params)
            redirect_to admin_course_materials_path, notice: "Course created successfully"
          else
            render :new
          end
        end
      end
    end

    def update
      @course_material = CourseMaterial.friendly.find(params[:id])
      respond_to do |format|
        format.json do
          if @course_material.update(course_material_params)
            render json: { message: "Course updated successfully" }, status: :ok
          else
            render json: { error: @course_material.errors.full_messages.join(", ") }, status: :unprocessable_entity
          end
        end

        format.html do
          if @course_material.update(course_material_params)
            redirect_to admin_course_materials_path, notice: "Course updated successfully"
          else
            render :edit
          end
        end
      end
    end

    def sort
      # Legacy sort
      params[:order].each_value { |v| CourseMaterial.find(v[:id]).update!(sort_order: v[:position]) }
      respond_to do |format|
        format.json { render json: true, status: :ok }
      end
    end

    private

    def course_material_params
      if !request.format.json? && params[:course_material][:sub_category_id].blank?
        # Backwards compatibility with legacy form. We don't want this behavior moving forward
        params[:course_material][:sub_category_id] = "" # Remove if not passed in.
      end

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
        course_material_files_attributes: %i[id file _destroy],
        course_material_medias_attributes: %i[id media _destroy],
        course_material_videos_attributes: %i[id url _destroy]
      )
    end

    def categories_array
      Category.order(:title).map do |c|
        category_title = c.organization.present? ? "#{c.title} (#{c.organization.title})" : c.title
        [category_title, c.id]
      end
    end

  end
end

module Admin
  class CoursesController < BaseController

    before_action :set_course, only: [:show, :edit, :update, :destroy]

    def index
      # TODO: scope
      @courses = Course.where.not(pub_status: "A")
    end

    def show

    end

    def new
      @course = Course.new
    end

    def edit

    end

    def create
      @course = Course.new

      # TODO: handle another way
      # if params[:course][:pub_status] == "P"
      #   @course.set_pub_date
      # end

      # TODO: handle with validation
      # @course.validate_has_unique_title

      if @course.update(course_params)
        if params[:commit] == "Save Course"
          redirect_to edit_admin_course_path(@course), notice: "Course was successfully created."
        else
          redirect_to new_admin_course_lesson_path(@course), notice: "Course was successfully created. Now add some lessons."
        end
      else
        render :new
      end
    end

    def update
      # The slug must be set to nil for the friendly_id to update on title change
      @course.slug = nil if @course.title != params[:course][:title]

      # TODO: handle another way
      # @course.update_pub_date(params[:course][:pub_status]) if params[:course][:pub_status] != @course.pub_status

      if @course.update(course_params)
        case params[:commit]
        when "Save Course"
          redirect_to edit_admin_course_path(@course), notice: "Course was successfully updated."
        when "Save Course and Edit Lessons"
          redirect_to edit_admin_course_lesson_path(@course, @course.lessons.first), notice: "Course was successfully updated."
        else
          redirect_to new_admin_course_lesson_path(@course), notice: "Course was successfully updated."
        end
      else
        render :edit
      end
    end

    def sort
      params[:order].each { |_k, v| Course.find(v[:id]).update_attribute(:course_order, v[:position]) }
      render nothing: true
    end

    def destroy
      @course.destroy
      redirect_to courses_url, notice: "Course was successfully destroyed."
    end

    private

    def set_course
      @course = Course.friendly.find(params[:id])
    end

    def course_params
      permitted_attributes = [ :title, :seo_page_title, :meta_desc, :summary,
        :description, :contributor, :pub_status, :notes, :delete_document,
        :course_order, :pub_date, attachments_attributes:
          [:course_id, :document, :title, :doc_type, :file_description, :_destroy]
      ]
      params.require(:course).permit(permitted_attributes)
    end

  end
end

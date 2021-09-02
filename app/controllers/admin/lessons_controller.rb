module Admin
  class LessonsController < BaseController

    before_action :set_course, except: [:sort]

    def show

    end

    def new
      @lesson = Lesson.new
    end

    def edit
      # TODO: this doesn't work if the title has changed.
      @lesson = @course.lessons.friendly.find(params[:id])
    end

    def create
      @lesson = @course.lessons.build(lesson_params)
      @lesson.duration_to_int(lesson_params[:duration])
      @lesson.lesson_order = @course.lessons.count + 1

      if @lesson.save
        Unzipper.new(@lesson.story_line) unless Rails.application.config.s3_enabled
        redirect_to edit_admin_course_lesson_path(@course, @lesson), notice: "Lesson was successfully created."
      else
        render :new
      end
    end

    def update
      @lesson ||= @course.lessons.friendly.find(params[:id])
      @lesson.slug = nil if @lesson.title != params[:lesson][:title] # Force regenerate if title changes.
      @lesson_params = lesson_params
      @lesson_params[:duration] = @lesson.duration_to_int(lesson_params[:duration])

      if @lesson.update(@lesson_params)
        Unzipper.new(@lesson.story_line) if @lesson.story_line_updated_at.present? && !Rails.application.config.s3_enabled
        redirect_to edit_admin_course_lesson_path, notice: "Lesson successfully updated."
      else
        render :edit, notice: "Lesson failed to update."
      end
    end

    def destroy_asl_attachment
      @lesson = @course.lessons.friendly.find(params[:format])
      @lesson.story_line = nil
      @lesson.save
      FileUtils.remove_dir "#{Rails.root}/public/storylines/#{@lesson.id}", true
      render :edit, notice: "Story Line successfully removed, please upload a new story line .zip file."
    end

    def sort
      params[:order].each { |_k, v| Lesson.find(v[:id]).update(lesson_order: v[:position]) }
      respond_to do |format|
        format.json { render json: true, status: :ok }
      end
    end

    private

    def set_course
      @course = Course.friendly.find(params[:course_id])
    end

    def lesson_params
      params.require(:lesson).permit(:title, :summary, :duration,
        :story_line, :seo_page_title, :meta_desc,
        :is_assessment, :lesson_order, :pub_status)
    end
  end
end

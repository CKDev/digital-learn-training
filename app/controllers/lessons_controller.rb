class LessonsController < ApplicationController
  before_action :set_course

  def index
    @lessons = @course.lessons.published
    respond_to do |format|
      format.html { render :index }
      format.json { render json: @lessons }
    end
  end

  def show
    @lesson = @course.lessons.friendly.find(params[:id])
    case @lesson.pub_status
    when "D"
      redirect_to course_path(@course), notice: "The selected lesson is not currently avaliable."
    when "A"
      redirect_to root_path, notice: "The selected lesson is no longer avaliable."
    when "P"
      session[:lessons_done] = [] if session[:lessons_done].blank?
      session[:lessons_done] << @lesson.id unless session[:lessons_done].include?(@lesson.id)
      @next_lesson = @course.lessons.find(@course.next_lesson_id(@lesson.id))

      # The change of course slug should 301 redirect.
      if request.path == course_lesson_path(@course, @lesson)
        render :show
      else
        redirect_to course_lesson_path(@course, @lesson), status: :moved_permanently
      end

    end
  end

  def lesson_complete
    @current_lesson = @course.lessons.friendly.find(params[:lesson_id])
    @next_lesson = @course.lessons.find(@course.next_lesson_id(@current_lesson.id))
  end

  def complete
    lesson = @course.lessons.friendly.find(params[:lesson_id])
    respond_to do |format|
      format.html do
        if lesson.is_assessment
          redirect_to course_complete_path(@course)
        else
          redirect_to course_lesson_path(@course, @course.next_lesson_id(lesson.id))
        end
      end
      format.json do
        render status: :ok, json: { complete: course_complete_path(@course) }
      end
    end
  end

  private

  def set_course
    @course = Course.friendly.find(params[:course_id])
  end

end

class CoursesController < ApplicationController

  def index
    @courses = Course.includes(:lessons).where(pub_status: "P") # TODO: scope
  end

  def show
    @course = Course.friendly.find(params[:id])

    case @course.pub_status
    when "D"
      flash[:notice] = "That course is not avaliable at this time."
      redirect_to root_path
    when "A"
      flash[:notice] = "That course is no longer avaliable."
      redirect_to root_path
    when "P"
      respond_to do |format|
        format.html do
          # Need to handle the change of course slug, which should 301 redirect.
          if request.path != course_path(@course)
            redirect_to @course, status: :moved_permanently
          else
            render :show
          end
        end
        format.json { render json: @course }
      end
    end
  end

  def start
    @course = Course.friendly.find(params[:course_id])
    redirect_to course_lesson_path(@course, @course.next_lesson_id)
  end

  def complete
    # TODO: Do we want to ensure that the assessment was completed to get here?
    @course = Course.friendly.find(params[:course_id])
    respond_to do |format|
      format.html
      format.pdf do
        @pdf = render_to_string pdf: "file_name",
               template: "courses/complete.pdf.erb",
               layout: "pdf.html.erb",
               orientation: "Landscape",
               page_size: "Letter",
               show_as_html: params[:debug].present?
        if current_user
          send_data(@pdf,
                    filename: "#{current_user.profile.first_name} #{@course.title} completion certificate.pdf",
                    type: "application/pdf")
        else
          send_data(@pdf,
                    filename: "#{@course.title} completion certificate.pdf",
                    type: "application/pdf")
        end
      end
    end
  end

  def your
    tracked_course_ids = current_user.course_progresses.tracked.collect(&:course_id)
    unless params[:search].blank?
      result_ids = PgSearch.multisearch(params[:search]).includes(:searchable).where(searchable_id: tracked_course_ids).map(&:searchable).map(&:id)
      @results = Course.where(id: result_ids)
    end

    @courses = params[:search].blank? ? Course.where(id: tracked_course_ids) : @results
    @skip_quiz = current_user.profile.opt_out_of_recommendations

    @category_ids = current_organization.categories.enabled.map(&:id)
    @disabled_category_ids = current_organization.categories.disabled.map(&:id)
    @disabled_category_courses = @courses.where(category_id: @disabled_category_ids)
    @uncategorized_courses = @courses.where(category_id: nil) + @disabled_category_courses

    respond_to do |format|
      format.html { render :your }
      format.json { render json: @courses }
    end
  end

  def completed
    completed_ids = current_user.course_progresses.completed.collect(&:course_id)
    @courses = Course.where(id: completed_ids)

    respond_to do |format|
      format.html { render "completed_list", layout: "user/logged_in_with_sidebar" }
      format.json { render json: @courses }
    end
  end

  def view_attachment
    @course = Course.friendly.find(params[:course_id])
    extension = File.extname(@course.attachments.find(params[:attachment_id]).document_file_name)
    if extension == ".pdf"
      file_options = { disposition: "inline", type: "application/pdf", x_sendfile: true }
    else
      file_options = { disposition: "attachment", type: [ "application/msword",
                                                  "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
                                                  "application/vnd.openxmlformats-officedocument.presentationml.presentation"],
                      x_sendfile: true}
    end
    send_file @course.attachments.find(params[:attachment_id]).document.path, file_options
  end

  def quiz
  end

  def quiz_submit
    current_user.update!(quiz_responses_object: quiz_params.to_h) unless current_user.quiz_responses_object.present?
    recommendation_service = CourseRecommendationService.new(current_organization.id, quiz_params)
    recommendation_service.add_recommended_courses(current_user.id)
    redirect_to your_courses_path
  end

  def skills
    @course = Course.friendly.find(params[:course_id])
  end

  def designing_courses_1
  end

  def designing_courses_2
  end

  private

  def find_language_id_by_session
    case session[:locale]
    when "en"
      1
    when "es"
      2
    end
  end

  def quiz_params
    params.permit("set_one", "set_two", "set_three")
  end
end

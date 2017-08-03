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
    @course = Course.friendly.find(params[:course_id])
    respond_to do |format|
      format.html
      format.pdf do
        # TODO: move these options elsewhere.
        @pdf = render_to_string pdf: "file_name",
               template: "courses/complete.pdf.erb",
               layout: "pdf.html.erb",
               orientation: "Landscape",
               page_size: "Letter",
               show_as_html: params[:debug].present?
        send_data(@pdf, filename: "#{@course.title} completion certificate.pdf", type: "application/pdf")
      end
    end
  end

  def view_attachment
    @course = Course.friendly.find(params[:course_id])
    extension = File.extname(@course.attachments.find(params[:attachment_id]).document_file_name)
    if extension == ".pdf"
      file_options = { disposition: "inline", type: "application/pdf", x_sendfile: true }
    else
      file_options = { disposition: "attachment",
        type: ["application/msword", "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
          "application/vnd.openxmlformats-officedocument.presentationml.presentation"],
        x_sendfile: true }
    end
    send_file @course.attachments.find(params[:attachment_id]).document.path, file_options
  end

end

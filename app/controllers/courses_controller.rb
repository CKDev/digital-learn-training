class CoursesController < ApplicationController

  def index
    @courses = Course.includes(:lessons).published
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
        @pdf = render_to_string pdf: "file_name",
               template: "courses/complete",
               layout: "pdf",
               orientation: "Landscape",
               page_size: "Letter"
        send_data(@pdf, filename: "#{@course.title} completion certificate.pdf", type: "application/pdf")
      end
    end
  end

  def view_attachment
    @course = Course.friendly.find(params[:course_id])
    @file = @course.attachments.find(params[:attachment_id])
    extension = File.extname(@file.document_file_name)

    data = AttachmentReader.new(@file).read_attachment_data("document")

    if extension == ".pdf"
      file_options = { disposition: "inline", filename: @file.document_file_name, type: "application/pdf", x_sendfile: true }
    else
      file_options = { disposition: "attachment", filename: @file.document_file_name, type: @file.document_content_type, x_sendfile: true }
    end
    send_data data, file_options
  end

end

class CourseMaterialsMediasController < ApplicationController

  def index
    @course_material = CourseMaterial.friendly.find(params[:course_material_id])

    course_title = @course_material.title.parameterize(separator: "_")
    file_options = { filename: "#{course_title}_media_archive.zip", disposition: "inline", x_sendfile: true }

    if Rails.application.config.s3_enabled
      send_file URI.parse(@course_material.media_archive.url).open, file_options
    else
      send_file File.open(@course_material.media_archive.path), file_options
    end
  end

  def show
    @course_material = CourseMaterial.friendly.find(params[:course_material_id])
    @file = @course_material.course_material_medias.find(params[:id])

    data = AttachmentReader.new(@file).read_attachment_data("media")

    file_options = { filename: @file.media_file_name, disposition: "inline", x_sendfile: true }
    send_data data, file_options
  end

end

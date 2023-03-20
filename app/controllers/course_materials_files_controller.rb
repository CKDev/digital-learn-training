require "zip"

class CourseMaterialsFilesController < ApplicationController

  def show
    @course_material = CourseMaterial.friendly.find(params[:course_material_id])
    @file = @course_material.course_material_files.find(params[:id])

    data = AttachmentReader.new(@file).read_attachment_data("file")

    file_options = { filename: @file.file_file_name, disposition: "inline" }
    send_data data, file_options
  end

  def index
    @course_material = CourseMaterial.friendly.find(params[:course_material_id])

    @files = @course_material.course_material_files.all

    zip_data = AttachmentZipper.new(@course_material, @files).create_zip("file")

    course_title = @course_material.title.parameterize(separator: '_')

    file_options = { filename: "#{course_title}_file_archive.zip", disposition: "inline", x_sendfile: true }
    send_data zip_data.read, file_options
  end

end

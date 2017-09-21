require "zip"

class CourseMaterialsFilesController < ApplicationController

  def show
    @course_material = CourseMaterial.friendly.find(params[:course_material_id])
    @file = @course_material.course_material_files.find(params[:id])
    data = open(@file.file.path)
    file_options = { filename: @file.file_file_name, disposition: "inline", x_sendfile: true }
    send_data data.read, file_options
  end

  def index
    @course_material = CourseMaterial.friendly.find(params[:course_material_id])
    @files = @course_material.course_material_files.all

    tempfile = Tempfile.new("file_archive", "tmp")

    ::Zip::File.open(tempfile.path, ::Zip::File::CREATE) do |zipfile|
      @files.each do |filename|
        zipfile.add(filename.file_file_name, filename.file.path)
      end
    end

    data = open(tempfile)
    file_options = { filename: "file_archive.zip", disposition: "inline", x_sendfile: true }
    send_data data.read, file_options
  end

end

require "zip"

class CourseMaterialsMediasController < ApplicationController

  def show
    @course_material = CourseMaterial.find(params[:course_material_id])
    @file = @course_material.course_material_medias.find(params[:id])
    data = open(@file.media.path)
    file_options = { disposition: "inline", x_sendfile: true }
    send_data data.read, file_options
  end

  def index
    @course_material = CourseMaterial.find(params[:course_material_id])
    @files = @course_material.course_material_medias.all

    tempfile = Tempfile.new("media_archive", "tmp")

    ::Zip::File.open(tempfile.path, ::Zip::File::CREATE) do |zipfile|
      @files.each do |filename|
        zipfile.add(filename.media_file_name, filename.media.path)
      end
    end

    data = open(tempfile)
    file_options = { filename: "media_archive.zip", disposition: "inline", x_sendfile: true }
    send_data data.read, file_options
  end

end

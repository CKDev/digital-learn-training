class CourseMaterialsFilesController < ApplicationController

  def show
    @course_material = CourseMaterial.find(params[:course_material_id])
    @file = @course_material.course_material_files.find(params[:id])
    data = open(@file.file.path)
    file_options = { disposition: "inline", x_sendfile: true }
    send_data data.read, file_options
  end

end

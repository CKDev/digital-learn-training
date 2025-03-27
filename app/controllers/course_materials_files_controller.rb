require 'open-uri'

class CourseMaterialsFilesController < ApplicationController

  def index
    @course_material = CourseMaterial.friendly.find(params[:course_material_id])
    course_title = @course_material.title.parameterize(separator: '_')
    file_name = "#{course_title}_file_archive.zip"

    FileDeliveryService.new(@course_material.file_archive, file_name).send_file_to_controller(self)
  end

  def show
    @course_material = CourseMaterial.friendly.find(params[:course_material_id])
    @file = @course_material.course_material_files.find(params[:id])
    file_name = @file.file_file_name

    FileDeliveryService.new(@file.file, file_name).send_file_to_controller(self)
  end
end

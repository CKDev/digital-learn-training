class CourseMaterialsMediasController < ApplicationController

  def index
    @course_material = CourseMaterial.friendly.find(params[:course_material_id])
    course_title = @course_material.title.parameterize(separator: '_')
    file_name = "#{course_title}_media_archive.zip"

    FileDeliveryService.new(@course_material.media_archive, file_name).send_file_to_controller(self)
  end

  def show
    @course_material = CourseMaterial.friendly.find(params[:course_material_id])
    @media = @course_material.course_material_medias.find(params[:id])
    file_name = @media.media_file_name

    FileDeliveryService.new(@media.media, file_name).send_file_to_controller(self)
  end
end

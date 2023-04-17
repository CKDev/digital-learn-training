class CourseMaterialArchiveJob < ApplicationJob
  queue_as :default

  def perform(course_material_id, association_name, attachment_type)
    logger.info("Creating #{association_name} zip archive for CourseMaterial #{course_material_id}")
    AttachmentZipper.new(course_material_id, association_name, attachment_type).create_zip
  end
end

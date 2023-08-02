class AddZipAttachmentsToCourseMaterials < ActiveRecord::Migration[5.2]
  def change
    add_attachment :course_materials, :file_archive
    add_attachment :course_materials, :media_archive
  end
end

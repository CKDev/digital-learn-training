class AddUniquenessIndicesToCourseMaterialAttachments < ActiveRecord::Migration[7.1]
  def change
    add_index :course_material_files, [:file_file_name, :course_material_id], unique: true, name: 'index_course_material_files_on_title_and_course_material_id'
    add_index :course_material_media, [:media_file_name, :course_material_id], unique: true, name: 'index_course_material_media_on_title_and_course_material_id'
  end
end

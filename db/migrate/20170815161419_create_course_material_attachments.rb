class CreateCourseMaterialAttachments < ActiveRecord::Migration[5.1]
  def change
    create_table :course_material_files do |t|
      t.integer :course_material_id
      t.attachment :file
      t.timestamps
    end

    create_table :course_material_media do |t|
      t.integer :course_material_id
      t.attachment :media
      t.timestamps
    end
  end
end

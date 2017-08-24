class CreateCourseMaterialVideos < ActiveRecord::Migration[5.1]
  def change
    create_table :course_material_videos do |t|
      t.integer :course_material_id
      t.string :url

      t.timestamps
    end
  end
end

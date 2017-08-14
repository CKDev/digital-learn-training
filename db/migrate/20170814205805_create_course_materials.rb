class CreateCourseMaterials < ActiveRecord::Migration[5.1]
  def change
    create_table :course_materials do |t|
      t.string :title, limit: 90
      t.string :summary, limit: 156
      t.text :description
      t.string :contributor, limit: 156
      t.timestamps
    end
  end
end

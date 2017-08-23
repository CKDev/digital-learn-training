class AddArchiveToCourseMaterials < ActiveRecord::Migration[5.1]
  def change
    add_column :course_materials, :archived, :boolean, default: false, null: false
  end
end

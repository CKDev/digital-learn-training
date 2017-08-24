class ChangeArchiveStatusOnCourseMaterials < ActiveRecord::Migration[5.1]
  def change
    add_column :course_materials, :pub_status, :string, default: "D", null: true
    remove_column :course_materials, :archived
  end
end

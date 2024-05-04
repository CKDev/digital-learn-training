class AddNewCourseFlagToCourseMaterials < ActiveRecord::Migration[6.1]
  def change
    add_column :course_materials, :new_course, :boolean, null: false, default: false
  end
end

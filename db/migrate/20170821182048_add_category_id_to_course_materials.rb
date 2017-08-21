class AddCategoryIdToCourseMaterials < ActiveRecord::Migration[5.1]
  def change
    add_column :course_materials, :category_id, :integer
  end
end

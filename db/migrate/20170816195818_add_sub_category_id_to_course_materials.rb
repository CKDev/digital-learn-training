class AddSubCategoryIdToCourseMaterials < ActiveRecord::Migration[5.1]
  def change
    add_column :course_materials, :sub_category_id, :integer
  end
end

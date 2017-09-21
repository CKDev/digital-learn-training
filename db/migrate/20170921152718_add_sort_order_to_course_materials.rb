class AddSortOrderToCourseMaterials < ActiveRecord::Migration[5.1]
  def change
    add_column :course_materials, :sort_order, :integer, null: false, default: 1
  end
end

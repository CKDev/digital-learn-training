class AddSlugColumnToCourseMaterials < ActiveRecord::Migration[5.1]
  def change
    add_column :course_materials, :slug, :string
  end
end

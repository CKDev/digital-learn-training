class CreateCourseMaterialImports < ActiveRecord::Migration[7.1]
  def change
    create_table :course_material_imports do |t|
      t.belongs_to :course_material
      t.belongs_to :organization

      t.timestamps
    end
  end
end

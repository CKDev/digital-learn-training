class AddLanguageToCourseMaterials < ActiveRecord::Migration[5.2]
  def change
    add_column :course_materials, :language, :string, default: :en
    CourseMaterial.update_all(language: :en)
  end
end

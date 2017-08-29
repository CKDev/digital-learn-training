class UpdateAllowedLengths < ActiveRecord::Migration[5.1]
  def change
    change_column :course_materials, :summary, :string, limit: 74
  end
end

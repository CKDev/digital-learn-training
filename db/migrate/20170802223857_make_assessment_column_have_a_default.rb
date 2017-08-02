class MakeAssessmentColumnHaveADefault < ActiveRecord::Migration[5.1]
  def change
    change_column :lessons, :is_assessment, :boolean, default: false, null: false
  end
end

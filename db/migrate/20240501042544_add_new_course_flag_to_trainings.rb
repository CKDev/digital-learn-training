class AddNewCourseFlagToTrainings < ActiveRecord::Migration[6.1]
  def change
    add_column :courses, :new_course, :boolean, null: false, default: false
  end
end

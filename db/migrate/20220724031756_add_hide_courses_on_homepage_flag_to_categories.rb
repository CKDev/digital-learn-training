class AddHideCoursesOnHomepageFlagToCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :hide_courses_on_homepage, :boolean, default: false, null: false
  end
end

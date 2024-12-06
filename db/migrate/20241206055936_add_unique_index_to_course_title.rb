class AddUniqueIndexToCourseTitle < ActiveRecord::Migration[7.1]
  def change
    add_index :courses, :title, unique: true
  end
end

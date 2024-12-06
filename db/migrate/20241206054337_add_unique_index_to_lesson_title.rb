class AddUniqueIndexToLessonTitle < ActiveRecord::Migration[7.1]
  def change
    add_index :lessons, [:title, :course_id], unique: true, name: 'index_lessons_on_title_and_course_id'
  end
end

class CreateLessons < ActiveRecord::Migration[5.1]
  def change
    create_table :lessons do |t|
      t.integer  :lesson_order
      t.string   :title,                   limit: 90
      t.integer  :duration
      t.integer  :course_id
      t.string   :slug
      t.string   :summary,                 limit: 156
      t.string   :story_line,              limit: 156
      t.string   :seo_page_title,          limit: 90
      t.string   :meta_desc,               limit: 156
      t.boolean  :is_assessment
      t.string  :pub_status, limit: 2, default: "D"
      t.string   :story_line_file_name
      t.string   :story_line_content_type
      t.integer  :story_line_file_size
      t.datetime :story_line_updated_at
      t.timestamps
    end
  end
end

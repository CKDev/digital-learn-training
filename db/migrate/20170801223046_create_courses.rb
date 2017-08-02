class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.string  :title, limit: 90
      t.string  :seo_page_title, limit: 90
      t.string  :meta_desc, limit: 156
      t.string  :summary, limit: 156
      t.text    :description
      t.text    :notes
      t.string  :contributor
      t.string  :pub_status, limit: 2, default: "D"
      t.string  :slug
      t.integer :course_order
      t.datetime :pub_date
      t.timestamps null: false
    end
  end
end

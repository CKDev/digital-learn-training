class CreateAttachments < ActiveRecord::Migration[5.1]
  def change
    create_table :attachments do |t|
      t.integer :course_id
      t.string :title
      t.string :doc_type
      t.string :file_description
      t.attachment :document
      t.timestamps null: false
    end
  end
end

class CreatePages < ActiveRecord::Migration[5.1]
  def change
    create_table :pages do |t|
      t.string :title, limit: 90
      t.text :body
      t.integer :pub_status, null: false, default: 0
      t.datetime :pub_at
      t.string :slug
      t.string :author, limit: 20
      t.string :seo_title, limit: 90
      t.string :meta_desc, limit: 156
      t.timestamps
    end

    add_index :pages, :title, unique: true
    add_index :pages, :pub_status
  end
end

class CreateAccessRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :access_requests do |t|
      t.belongs_to :organization
      t.string :full_name, null: false
      t.string :email, null: false
      t.string :organization_name, null: false
      t.string :phone
      t.string :poc_name
      t.string :poc_email
      t.text :request_reason

      t.timestamps
    end
  end
end

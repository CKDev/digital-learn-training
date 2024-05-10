class CreateCollaboratorProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :collaborator_profiles do |t|
      t.references :user
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :phone
      t.string :organization_name
      t.string :organization_city
      t.string :organization_state
      t.string :poc_name
      t.string :poc_email
      t.boolean :terms_of_service, null: false, default: false

      t.timestamps
    end
  end
end

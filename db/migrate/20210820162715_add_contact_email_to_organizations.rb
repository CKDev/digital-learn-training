class AddContactEmailToOrganizations < ActiveRecord::Migration[5.2]
  def change
    add_column :organizations, :contact_email, :string
  end
end

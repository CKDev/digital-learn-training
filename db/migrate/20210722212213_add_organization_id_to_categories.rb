class AddOrganizationIdToCategories < ActiveRecord::Migration[5.1]
  def change
    add_reference :categories, :organization
  end
end

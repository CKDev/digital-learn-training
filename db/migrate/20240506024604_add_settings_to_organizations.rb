class AddSettingsToOrganizations < ActiveRecord::Migration[6.1]
  def change
    add_column :organizations, :settings, :jsonb, null: false, default: {}
  end
end

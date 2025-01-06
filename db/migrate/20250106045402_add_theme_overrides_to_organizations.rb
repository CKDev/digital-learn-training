class AddThemeOverridesToOrganizations < ActiveRecord::Migration[7.1]
  def change
    add_column :organizations, :theme_overrides, :jsonb, null: false, default: {}
  end
end

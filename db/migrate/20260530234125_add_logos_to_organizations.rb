class AddLogosToOrganizations < ActiveRecord::Migration[7.1]
  def change
    add_column :organizations, :header_logo_file_name, :string
    add_column :organizations, :header_logo_content_type, :string
    add_column :organizations, :header_logo_file_size, :bigint
    add_column :organizations, :header_logo_updated_at, :datetime
    add_column :organizations, :footer_logo_file_name, :string
    add_column :organizations, :footer_logo_content_type, :string
    add_column :organizations, :footer_logo_file_size, :bigint
    add_column :organizations, :footer_logo_updated_at, :datetime
  end
end

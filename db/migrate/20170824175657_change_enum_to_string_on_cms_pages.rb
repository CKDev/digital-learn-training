class ChangeEnumToStringOnCmsPages < ActiveRecord::Migration[5.1]
  def change
    change_column :pages, :pub_status, :string, null: false
  end
end

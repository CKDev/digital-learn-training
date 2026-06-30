# frozen_string_literal: true

class AssignNationalCategoriesToWwwOrg < ActiveRecord::Migration[7.1]
  def up
    www_org = Organization.find_by!(subdomain: 'www')
    Category.where(organization_id: nil).update_all(organization_id: www_org.id)
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end

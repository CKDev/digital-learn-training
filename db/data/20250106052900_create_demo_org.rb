# frozen_string_literal: true

class CreateDemoOrg < ActiveRecord::Migration[7.1]
  def up
    Organization.create(
      title: 'Demo',
      subdomain: 'demo',
      palette: { primary: { main: '#006600', light: '#669999' }, info: { main: '#8c1aff', dark: '#330066' } }
    )

    # TODO: Import courses for organization
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end

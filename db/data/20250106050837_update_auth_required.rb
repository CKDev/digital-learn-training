# frozen_string_literal: true

class UpdateAuthRequired < ActiveRecord::Migration[7.1]
  def up
    # We're changing the default to non-required
    Organization.all.update(authentication_required: true)
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end

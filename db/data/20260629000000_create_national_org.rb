# frozen_string_literal: true

class CreateNationalOrg < ActiveRecord::Migration[7.1]
  def up
    Organization.find_or_create_by(subdomain: 'www') do |org|
      org.title = 'DigitalLearn'
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end

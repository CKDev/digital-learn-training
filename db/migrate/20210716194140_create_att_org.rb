class CreateAttOrg < ActiveRecord::Migration[5.1]
  def change
    Organization.create(title: 'AT&T', subdomain: 'att')
  end
end

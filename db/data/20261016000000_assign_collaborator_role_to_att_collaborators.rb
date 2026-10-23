# frozen_string_literal: true

class AssignCollaboratorRoleToAttCollaborators < ActiveRecord::Migration[7.1]
  def up
    att_org = Organization.find_by!(subdomain: 'att')
    User.joins(:collaborator_profile).find_each do |user|
      user.add_role(:collaborator, att_org)
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end

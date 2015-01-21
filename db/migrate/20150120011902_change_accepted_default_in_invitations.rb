class ChangeAcceptedDefaultInInvitations < ActiveRecord::Migration
  def up
    change_column :invitations, :accepted, :boolean, default: false
  end

  def down
    change_column :invitations, :accepted, :boolean
  end
end

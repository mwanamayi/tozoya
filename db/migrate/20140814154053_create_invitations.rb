class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.references :event, index: true
      t.references :user, index: true
      t.boolean :accepted, default: false

      t.timestamps
    end
  end
end

class CreateClassRegistrations < ActiveRecord::Migration
  def up
    create_table :class_registrations, force: true do |t|
      t.references :course, index: true
      t.references :user, index: true
    end
  end

  def down
    drop_table :class_registrations
  end
end

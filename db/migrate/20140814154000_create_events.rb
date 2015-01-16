class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :user_id
      t.string :name
      t.string :description
      t.string :venue
      t.string :location

      t.timestamps
    end
  end
end

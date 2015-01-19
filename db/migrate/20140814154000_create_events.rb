class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :user, index: true
      t.string :name
      t.string :description
      t.string :venue
      t.string :location

      t.timestamps
    end
  end
end

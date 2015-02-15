class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :user, index: true
      t.string :name
      t.string :description
      t.string :location_name
      t.string :location_address
      t.time :start_time
      t.date :start_date
      t.datetime :datetime

      t.timestamps
    end
  end
end

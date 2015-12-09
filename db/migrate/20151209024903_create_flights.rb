class CreateFlights < ActiveRecord::Migration
  def change
    create_table :flights do |t|
      t.text :content
      t.references :user
      t.string :picture
      t.boolean :public
      t.string :departure
      t.string :destination
      t.datetime :date

      t.timestamps
    end
    add_index :flights, :user_id
  end
end

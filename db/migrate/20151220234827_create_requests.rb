class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.text :content
      t.string :picture
      t.boolean :public
      t.string :departure
      t.string :destination
      t.datetime :date
      t.float :latitude
      t.float :longitude
      t.references :user

      t.timestamps
    end
  end
end

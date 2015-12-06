class CreateFlights < ActiveRecord::Migration
    def change
        create_table :flights do |t|
            t.text     :content
            t.integer  :user_id
            t.string   :picture
            t.boolean  :public, default: false
            t.string   :departure, default: ""
            t.string   :destination, default: ""
            t.date     :date

            t.timestamps null: false
        end
    end
end

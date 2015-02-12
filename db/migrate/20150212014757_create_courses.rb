class CreateCourses < ActiveRecord::Migration
  def up
    create_table :courses, force: true do |t|
      t.references :school, index: true
      t.references :user, index: true
      t.string :name, index: true
    end
  end

  def down
    drop_table :classes
  end
end

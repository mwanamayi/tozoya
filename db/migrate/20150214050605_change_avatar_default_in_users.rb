class ChangeAvatarDefaultInUsers < ActiveRecord::Migration
  def up
    change_column :users, :avatar, :string, default: "http://thenittygritty.co/content/01-home/003-css-masking/mouse-black.png"
  end

  def down
    change_column :users, :avatar, :string
  end
end

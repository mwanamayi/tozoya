class AddUserAvatarToEvents < ActiveRecord::Migration
  def up
    add_column :events, :user_avatar, :string, default: ""
  end

  def down
    remove_column :events, :user_avatar
  end
end

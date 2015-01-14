class Task < ActiveRecord::Base
  belongs_to :creator, class_name: "User",
                       foreign_key: :user_id

  attr_accessible :title, :user_id

  validates_presence_of :title

  default_scope order('completed ASC, created_at DESC')

  def open!
    update_column(:completed, false)
  end

  def complete!
    update_column(:completed, true)
  end
end
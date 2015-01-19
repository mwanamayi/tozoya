class Invitation < ActiveRecord::Base
  belongs_to :event
  belongs_to :invited_user, class_name: "User", foreign_key: :user_id

  attr_accessible :event_id, :user_id, :accepted

  def invited_user_name
    self.invited_user.username
  end

  def event_name
    self.event.name
  end

  def accept!
    update_column(:accepted, true)
  end

  def reject!
    update_column(:accepted, false)
  end

end

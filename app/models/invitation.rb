class Invitation < ActiveRecord::Base
  belongs_to :event
  belongs_to :invited_user, class_name: "User",
                    foreign_key: :user_id

  attr_accessible :event_id, :user_id, :status

  def invited_user_name
    self.invited_user.username
  end

  def event_name
    self.event.name
  end

end

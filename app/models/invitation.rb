class Invitation < ActiveRecord::Base
  belongs_to :event
  belongs_to :creator, class_name: "User",
                    foreign_key: :user_id

  def invited_user(user_id)
    self.creator.name
  end

  def event_name
    self.event.name
  end

end

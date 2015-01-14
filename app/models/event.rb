class Event < ActiveRecord::Base
  belongs_to :creator, class_name: "User",
                       foreign_key: :user_id
  has_many :invitations
  has_many :invited_users, through: :invitations, source: :user

  attr_accessible :user_id, :name, :description, :start_time, :end_time, :venue , :location, :notify_user, :notify_hours_until_event

  def attending_users
    self.invitations.where(status: "in").map { |invite| User.find(invite.user_id)}
  end

  def attending_users
    self.invitations.where(status: "in").map { |invite| User.find(invite.user_id)}
  end

  def creator
    if self.user_id
      creator = User.find(self.user_id)
      creator.username
    end
  end

end

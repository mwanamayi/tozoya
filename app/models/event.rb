class Event < ActiveRecord::Base
  belongs_to :creator, class_name: "User",
                       foreign_key: :user_id
  has_many :invitations
  has_many :invited_users, through: :invitations, source: :user

  # just_define_datetime_picker :start_time, :add_to_attr_accessible => true
  # just_define_datetime_picker :end_time, :add_to_attr_accessible => true


  attr_accessible :id, :user_id, :name, :description, :venue , :location
  # , :notify_user, :notify_hours_until_event, :start_time, :end_time, 

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

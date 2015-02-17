class Event < ActiveRecord::Base
  belongs_to :creator, class_name: "User",
                       foreign_key: :user_id
  belongs_to :user
  has_many :invitations
  has_many :users, through: :invitations, source: :user

  delegate :avatar, to: :user

  before_create :add_user_avatar
  before_create :merge_time_and_date

  # just_define_datetime_picker :start_time, :add_to_attr_accessible => true
  # just_define_datetime_picker :end_time, :add_to_attr_accessible => true


  attr_accessible :id, :user_id, :name, :description, :location_name , :location_address, :start_time, :start_date, :datetime, :creator
  # , :notify_user, :notify_hours_until_event, :start_time, :end_time, 

  default_scope order('datetime ASC')

  def attending_users
    self.invitations.where(accepted: "true").map { |invite| User.find(invite.user_id)}
  end

  def creator
    if self.user_id
      creator = User.find(self.user_id)
      creator.username
    end
  end

  def invited_users
    invited_users = []
    invitations = self.invitations
    invitations.each do |i|
      invited_users << i.invited_user
      invited_users
    end
    invited_users
  end

  def add_user_avatar
    creator = User.find(self.user_id)
    self.user_avatar = creator.avatar
  end

  def merge_time_and_date
    if self.start_time && self.start_date
      time_to_merge = self.start_time
      date_to_merge = self.start_date
      merged_datetime = DateTime.new(date_to_merge.year, date_to_merge.month,
                                 date_to_merge.day, time_to_merge.hour,
                                 time_to_merge.min, time_to_merge.sec)
      self.datetime = merged_datetime
    end
  end

  def format_datetime
    # self.datetime.strftime('%a, %b %d, %I:%M%p')
    self.datetime.strftime('%b %d, %I:%M%p')
  end

end

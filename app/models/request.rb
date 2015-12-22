class Request < ActiveRecord::Base
  belongs_to :user
  attr_accessible :content, :date, :departure, :destination, :picture, :public, :latitude, :longitude
  geocoded_by :destination
  after_validation :geocode, if: :destination_changed?
  before_create :set_user_id

  default_scope order('date ASC')
  
  # self.per_page = 0

  def self.day(date)
    # self.datetime.strftime('%a, %b %d, %I:%M%p')
    date.strftime('%B %d, %Y')
  end

  def self.time(date)
    # self.datetime.strftime('%a, %b %d, %I:%M%p')
    date.strftime('%I:%M%p')
  end

  def set_user_id
    self.user_id = User.current.id
  end
end

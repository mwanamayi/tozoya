class Flight < ActiveRecord::Base
  belongs_to :user
  belongs_to :flight
  attr_accessible :content, :date, :departure, :destination, :picture, :public, :latitude, :longitude
  geocoded_by :destination
  after_validation :geocode, if: :destination_changed?

  def self.day(date)
    # self.datetime.strftime('%a, %b %d, %I:%M%p')
    date.strftime('%B %d, %Y')
  end

  def self.time(date)
    # self.datetime.strftime('%a, %b %d, %I:%M%p')
    date.strftime('%I:%M%p')
  end
end

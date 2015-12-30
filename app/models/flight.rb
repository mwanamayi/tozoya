class Flight < ActiveRecord::Base
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

  def self.filter(params)
    search = params[:search]
      filtered_flights =  []
    if search && search.present?
      flights = Flight.where('lower(departure) LIKE ? OR lower(destination) LIKE ? AND date > ?', "%#{search.downcase}%","%#{search.downcase}%",DateTime.now)
    else
      flights = Flight.where(['date > ?', DateTime.now])
    end

    if flights.count > 0
      flights.each do |r|
        if User.current.friend?(r.user)
          filtered_flights << r
        elsif r.public? || User.current == r.user
          filtered_flights << r
        end
      end
      @flights = filtered_flights.present? ? filtered_flights.paginate(:page => params[:page]) : []
    else
      @flights = []
    end

  end

end

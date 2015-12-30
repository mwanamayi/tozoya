class Request < ActiveRecord::Base
  belongs_to :user
  attr_accessible :content, :date, :departure, :destination, :picture, :public, :latitude, :longitude
  geocoded_by :destination
  after_validation :geocode, if: :destination_changed?
  before_create :set_user_id

  default_scope order('date ASC')
  mount_uploader :picture, PictureUploader
  before_create :downcase_everything

  # self.per_page = 0


  def downcase_everything
    self.departure.downcase! if departure
    self.destination.downcase! if destination
  end

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
    requests = []
    filtered_requests =  []
    if search && search.present?
      puts "search"
      requests = Request.where('lower(departure) LIKE ? OR lower(destination) LIKE ? AND date > ?', "%#{search.downcase}%","%#{search.downcase}%",DateTime.now)
      puts requests
    else
      puts "no search"
      requests = Request.where(['date > ?', DateTime.now])
      puts requests
    end

    if requests.count > 0
      requests.each do |r|
        puts r
        if User.current.friend?(r.user)
          filtered_requests << r
        elsif r.public? || User.current == r.user
          filtered_requests << r
        end
        filtered_requests
      end
      @requests = filtered_requests.present? ? filtered_requests.paginate(:page => params[:page]) : []
    else
      @requests = []
    end
    puts "final requests are:"
    puts @requests
    @requests

  end

end

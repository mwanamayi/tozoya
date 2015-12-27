class User < ActiveRecord::Base

  acts_as_follower
  acts_as_followable

  has_many :invitations
  has_many :invited_events, through: :invitations, source: :event
  has_many :created_events, class_name: "Event", foreign_key: :user_id
  has_many :courses, through: :class_registrations, source: :course
  has_many :class_registrations
  has_many :conversations, foreign_key: :sender_id
  has_many :flights
  has_many :requests
  has_many :messages

  belongs_to :school
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :token_authenticatable

  devise :omniauthable, :omniauth_providers => [:facebook]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :status, :first_name, :last_name, :avatar, :password, :password_confirmation, :remember_me, :school_id
  attr_accessible :entity_name, :remote_avatar_url, :auth_method

  has_many :tasks

  before_save :ensure_authentication_token
  before_create :downcase_everything
  before_create :skip_confirmation!

  # validates :email, uniqueness: { case_sensitive: false }
  # validates :username, uniqueness: { case_sensitive: false }

  default_scope order('first_name ASC')
  mount_uploader :avatar, PictureUploader

  def full_name
    "#{self.first_name}".capitalize + " " + "#{self.last_name}".capitalize
  end

  def skip_confirmation!
    self.confirmed_at = Time.now
  end

  def downcase_everything
    self.first_name.downcase! if first_name
    self.last_name.downcase! if last_name
    self.email.downcase! if email
    # self.username.downcase! if username
    self.entity_name.downcase! if entity_name
  end

  def update_facebook_pic(image)
    if self.avatar != image
      self.update_attributes!(remote_avatar_url: image.sub('http:','https:'))
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name 
    end
  end

  def self.current
    Thread.current[:user]
  end
  
  def self.current=(user)
    Thread.current[:user] = user
  end

  def attending_events
    events = []
    invitations = Invitation.where(user_id: self.id, accepted: true)
    invitations.each do |i|
      events << i.event
      events
    end
    events
  end

  def friend?(user)
    self.followed_by?(user) && self.following?(user)
  end

  def friends
    users = User.all
    friends = []
    users.each do |u|
      if self.followed_by?(u) && self.following?(u)
        friends << u
      end
    end
    return friends
  end

  def friend_requests
    users = User.all
    friend_requests = []
    users.each do |u|
      if self.followed_by?(u) && !self.following?(u)
        friend_requests << u
      end
    end
    return friend_requests
  end

  def pending_requests
    users = User.all
    pending_requests = []
    users.each do |u|
      if !self.followed_by?(u) && self.following?(u)
        pending_requests << u
      end
    end
    return pending_requests
  end

  def filter(search)
    if search && search.present?
      User.where('lower(first_name) LIKE ? OR lower(last_name) LIKE ?', "%#{search.downcase}%","%#{search.downcase}%")
    else
      pending_requests + friend_requests + friends
    end
  end

  # def picture_size
  #   if picture.size > 1.megabytes
  #     errors.add(:avatar, "should be less than 1MB")
  #   end
  # end

end





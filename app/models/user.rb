class User < ActiveRecord::Base

  acts_as_follower
  acts_as_followable

  has_many :invitations
  has_many :invited_events, through: :invitations, source: :event
  has_many :created_events, class_name: "Event", foreign_key: :user_id
  has_many :courses, through: :class_registrations, source: :course
  has_many :class_registrations

  belongs_to :school
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :token_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :status, :first_name, :last_name, :avatar, :password, :password_confirmation, :remember_me, :school_id
  # attr_accessible :title, :body

  has_many :tasks

  before_save :ensure_authentication_token
  before_create :skip_confirmation!

  def skip_confirmation!
    self.confirmed_at = Time.now
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
end
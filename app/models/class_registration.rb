class ClassRegistration < ActiveRecord::Base
  belongs_to :course
  belongs_to :user
  has_many :class_registrations

  attr_accessible :course_id, :user_id

end

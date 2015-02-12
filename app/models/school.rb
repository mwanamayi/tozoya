class School < ActiveRecord::Base

  has_many :courses
  has_many :users

  attr_accessible :name

end
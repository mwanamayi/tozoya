class School < ActiveRecord::Base

  has_many :courses
  has_many :users

  attr_accessible :name

  def student_count
    self.users.where(status:"student").count
  end

  def professor_count
    self.users.where(status:"professor").count
  end

end
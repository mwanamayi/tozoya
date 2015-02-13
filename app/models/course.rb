class Course < ActiveRecord::Base

  has_many :class_registrations
  has_many :students, through: :class_registrations, source: :user
  belongs_to :professor, class_name: "User", foreign_key: :user_id

  attr_accessible :name

  def student_count
    if self.class_registrations.count > 0
      self.class_registrations.count
    else
      0
    end
  end

  def professor_full_name
    self.professor.first_name + " " + self.professor.last_name
  end

end
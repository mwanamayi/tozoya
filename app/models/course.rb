class Course < ActiveRecord::Base

  attr_accessible :name
    belongs_to :professor, class_name: "User",
                       foreign_key: :user_id
    belongs_to :school

  attr_accessible :name, :user_id, :school_id

end
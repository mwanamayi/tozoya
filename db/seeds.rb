
####################################### ADMINS

admins = [{:email => 'lisa@example.com', :password => 'secret', :password_confirmation => 'secret', username: "lisa"},
          {:email => 'joel@example.com', :password => 'secret', :password_confirmation => 'secret', username: "joel"}]

admins.each do |admin|
    AdminUser.create!admin
  end


####################################### SCHOOLS

schools = [{name: "New York University"}, 
           {name: "Pace University"}, 
           {name: "Columbia"}, 
           {name: "Berkeley College"}, 
           {name: "Lycee Francais Jules Verne"}, 
           {name: "Mc'Gill"}, 
           {name: "Yale"}]

schools.each do |school|
  School.create!school
end

@nyu = School.all.first

####################################### USERS

900.times do 
  user = User.create!(email: Faker::Internet.email, username: Faker::Name.first_name, password: "secret", first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, avatar: Faker::Avatar.image, status: "student")
  @nyu.users << user

  @students = User.where(status: "student")
end

100.times do 
  professor = User.create!(email: Faker::Internet.email, username: Faker::Name.first_name, password: "secret", first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, avatar: Faker::Avatar.image, status: "professor", school_id: @nyu_id)
  @nyu.users << professor
end

@professors = User.where(status: "professor")

######################################## CLASSES

@professors.count do
  course = Course.create!(name: Faker::Commerce.department(3, true))
  @nyu.courses << course
end

 @courses = Course.all

 i = 0
 @courses.each do |c|
  c.professor = @professors[i]
  i += 1
  i
 end

######################################## EVENTS

50.times do
  Event.create!(name: Faker::Lorem.word, description: Faker::Lorem.sentence(3), location_name: Faker::App.name, location_address: Faker::Address.street_address + "," + Faker::Address.city + "," + Faker::Address.state)
end

# ######################################## INVITATIONS

invite_statuses = [true, false]

374.times do
  Invitation.create!(event_id: rand(1...50), user_id: rand(1...1000),accepted:invite_statuses.sample )
end

######################################### REGISTRATIONS

def create_class_registration(class_id, student_id)
  ClassRegistration.create!(course_id: class_id, user_id: student_id )
end

def get_class_id(student)
  @class_id = rand(0...@courses.count)
  check_recurring_class_id(student, @class_id)
end

def register_students_for_class

  @students.each do |s|
    4.times do
      get_class_id(s)
    end
  end
end

def check_recurring_class_id(student, course_id)
  if student.class_registrations.empty?
    create_class_registration(course_id, student.id)
  else
    student.class_registrations.each do |r|
      if r.class_id == course_id
        get_class_id(student)
      end
    end
  end
end

register_students_for_class



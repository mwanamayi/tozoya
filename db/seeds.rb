
# ####################################### ADMINS

admins = [{:email => 'lisa@example.com', :password => 'secret', :password_confirmation => 'secret', username: "lisa"},
          {:email => 'joel@example.com', :password => 'secret', :password_confirmation => 'secret', username: "joel"}]

admins.each do |admin|
    AdminUser.create!admin
  end


# ####################################### SCHOOLS

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

# ####################################### USERS

200.times do 
  person = FakePerson.new
  user = User.create!(email: person.free_email_address, username: person.username, password: "secret", first_name: person.first_name, last_name: person.last_name, avatar: person.avatar_url, status: "student")
  if !user.save

  end
  @nyu.users << user

  @students = User.where(status: "student")
end

@users = User.all

50.times do   
  person = FakePerson.new
  professor = User.create!(email: person.free_email_address, username: person.username, password: "secret", first_name: person.first_name, last_name: person.last_name, avatar: person.avatar_url, status: "professor", school_id: @nyu_id)
  @nyu.users << professor
end

@professors = User.where(status: "professor")

person = FakePerson.new
my_users = [{:email => 'lisa.asmussen@.gmail.com', :password => 'secret', :password_confirmation => 'secret', username: "lisa_asmussen", avatar: person.avatar_url, status: "student", school_id: @nyu_id},
          {:email => 'joelyawili@hotmail.com', :password => 'secret', :password_confirmation => 'secret', username: "joelyawili", avatar: person.avatar_url, status: "student", school_id: @nyu_id}]

my_users.each do |users|
    User.create!users
end

# ####################################### COURSES

@professors.each do |p|
  course = Course.new(name: Faker::Commerce.department(3, true))
  course.professor = p
  course.save!
  @nyu.courses << course
end

 @courses = Course.all


######################################## EVENTS

50.times do
  e = Event.new(name: Faker::Lorem.word, description: Faker::Lorem.sentence(3), location_name: Faker::App.name, location_address: Faker::Address.street_address + "," + Faker::Address.city + "," + Faker::Address.state)
  user = User.find(rand(1...@users.count))
  e.user = user
  e.save!
  user.created_events << e
end

@events = Event.all
@events.each do |e|
  e.user = User.find(rand(1...@users.count))
  e.user_avatar = e.user.avatar
  e.save
end
######################################## INVITATIONS

invite_statuses = [true, false]

374.times do
  Invitation.create!(event_id: rand(1...50), user_id: rand(1...@users.count),accepted:invite_statuses.sample )
end

######################################## REGISTRATIONS

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



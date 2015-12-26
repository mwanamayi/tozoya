
# ####################################### ADMINS

admins = [{:email => 'lisa@example.com', :password => 'secret', :password_confirmation => 'secret', username: "lisa"},
          {:email => 'jcyawili@hotmail.com', :password => 'secret', :password_confirmation => 'secret', username: "mwanamayi"},
          {:email => 'joel@example.com', :password => 'secret', :password_confirmation => 'secret', username: "joel"}]

admins.each do |admin|
    AdminUser.create!admin
  end


# ####################################### SCHOOLS

schools = [{name: "Science Po Paris"},
          {name: "New York University"}, 
           {name: "Pace University"}, 
           {name: "Columbia"}, 
           {name: "Berkeley College"}, 
           {name: "Lycee Francais Jules Verne"}, 
           {name: "Mc'Gill"}, 
           {name: "Yale"}]

schools.each do |school|
  School.create!school
end

@science_po = School.all.first

# ####################################### USERS

100.times do 
  person = FakePerson.new
  user = User.create!(email: person.free_email_address, username: person.username, password: "secret", 
                      first_name: person.first_name, last_name: person.last_name, avatar: person.avatar_url, status: "student", entity_name: Faker::Company.name)
  if !user.save

  end
  @science_po.users << user

  @students = User.where(status: "student")
end

10.times do   
  person = FakePerson.new
  professor = User.create!(email: person.free_email_address, username: person.username, password: "secret", 
                          first_name: person.first_name, last_name: person.last_name, avatar: person.avatar_url, 
                          status: "professor", school_id: @science_po_id, entity_name: Faker::Company.name)
  @science_po.users << professor
end

@professors = User.where(status: "professor")

person = FakePerson.new
my_users = [{:email => 'lisa.asmussen@.gmail.com', :password => 'secret', :password_confirmation => 'secret', 
              username: "lisa_asmussen", avatar: person.avatar_url, status: "student", school_id: @science_po_id,first_name: "Lisa", last_name: "Asmussen",entity_name: "Berkeley"},
          {:email => 'joelyawili@hotmail.com', :password => 'secret', :password_confirmation => 'secret', 
            username: "joelyawili", avatar: person.avatar_url, status: "student", school_id: @science_po_id, first_name: "Joel", last_name: "Yawili", entity_name: "Appnexus"},
          {:email => 'jcyawili@hotmail.fr', :password => 'secret', :password_confirmation => 'secret', 
            username: "mwanamayi", avatar: person.avatar_url, status: "student", school_id: @science_po_id, first_name: "JC", last_name: "Yawili", entity_name: "Science Po"}]

my_users.each do |user|
    created_user = User.create!user
    @science_po.users << created_user
end


@users = User.all
# ####################################### COURSES
  bachelors = Course.create!(name: "Bachelor's")
  masters = Course.create!(name: "Masters")

  @science_po.courses << bachelors
  @science_po.courses << bachelors

  @courses = Course.all


######################################## EVENTS

# 50.times do
#   e = Event.new(name: Faker::Lorem.word, description: Faker::Lorem.sentence(3), location_name: Faker::App.name, 
#                 location_address: Faker::Address.street_address + "," + Faker::Address.city + "," + Faker::Address.state,
#                 start_date: Faker::Time.forward(30),end_date: Faker::Time.forward(30))
#   user = User.find(rand(1...@users.count))
#   e.user = user
#   e.save!
#   user.created_events << e
# end

50.times do
  # f = Flight.new(departure: Faker::Address.city + "," + Faker::Address.country, destination: Faker::Address.city + "," + Faker::Address.country , public: [true,false].sample,
  #               date: Faker::Time.forward(180))
  # user = User.find(rand(1...@users.count))

  f = Flight.new(departure: Faker::Address.city + "," + Faker::Address.country, destination: Faker::Address.city , public: [true,false].sample,
                date: Faker::Time.forward(180))
  user = User.find(rand(1...@users.count))

  f.user = user
  f.save!
  user.flights << f
end

50.times do

  r = Request.new(departure: Faker::Address.city + "," + Faker::Address.country, destination: Faker::Address.city , public: [true,false].sample,
                date: Faker::Time.forward(180))
  user = User.find(rand(1...@users.count))

  r.user = user
  r.save!
  user.requests << r
end

@events = Event.all
@events.each do |e|
  e.user = User.find(rand(1...@users.count))
  e.user_avatar = e.user.avatar
  e.save
end
######################################## INVITATIONS

invite_statuses = [true, false]

85.times do
  Invitation.create!(event_id: rand(1...50), user_id: rand(1...(@users.count-2)),accepted:invite_statuses.sample )
end

25.times do
  Invitation.create!(event_id: rand(1...50), user_id: 111 , accepted:invite_statuses.sample )
  Invitation.create!(event_id: rand(1...50), user_id: 112 , accepted:invite_statuses.sample )
  Invitation.create!(event_id: rand(1...50), user_id: 113 , accepted:invite_statuses.sample )
end

######################################## REGISTRATIONS

def create_class_registration(class_id, student_id)
  print "here 5"
  ClassRegistration.create!(course_id: class_id, user_id: student_id )
end

def get_class_id(student)
  @class_id = rand(0...@courses.count)
  check_recurring_class_id(student, @class_id)
end

def register_students_for_class
  @students.each do |s|
    1.times do
      get_class_id(s)
    end
  end
end

def check_recurring_class_id(student, course_id)
  if not student.class_registrations
    create_class_registration(course_id, student.id)
  else
    student.class_registrations.each do |r|
      if r.class_id == course_id
        get_class_id(student)
      end
    end
  end
end

def create_conversation(user)
  recipient = User.find(rand(1...@users.count))
  conversation = Conversation.create!(sender_id: user.id, recipient_id: recipient.id)
  ids = [user.id, recipient.id]

  5.times do
    message_sender_id = ids.sample
    create_message(conversation.id,message_sender_id)
  end

end

def create_message(conversation_id, message_sender_id)
  message = Message.create!(body: Faker::Lorem.sentence(3, true), conversation_id: conversation_id, user_id: message_sender_id)
end


register_students_for_class

@users.each do |user|
  create_conversation(user)
end



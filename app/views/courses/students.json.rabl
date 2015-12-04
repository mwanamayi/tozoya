object false
node (:success) { true }
node (:info) { 'ok' }
child :data do
  node (:students_count) { @students.size }
  child @students do
    attributes :id, :username, :first_name, :last_name, :status, :avatar
  end
end
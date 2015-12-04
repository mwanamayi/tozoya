object false
node (:success) { true }
node (:info) { 'ok' }
child :data do
  node (:registered_courses_count) { @registered_courses.size }
  child @registered_courses do
    attributes :id, :name
  end
end
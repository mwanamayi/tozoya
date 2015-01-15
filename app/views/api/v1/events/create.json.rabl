object false
node (:success) { true }
node (:info) { 'Event created!' }
child :data do
  child @event do
    attributes :user_id, :name, :description, :start_time, :end_time, :venue , :location, :notify_user, :notify_hours_until_event
  end
end
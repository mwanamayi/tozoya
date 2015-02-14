object false
node (:success) { true }
node (:info) { 'ok' }
child :data do
  node (:events_count) { @attending_events.size }
  child @attending_events do
    attributes :id,:user_id, :name, :description, :start_time, :end_time, :venue , :location, :notify_user, :notify_hours_until_event, :user_avatar
  end
end
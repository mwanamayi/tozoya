object false
node (:success) { true }
node (:info) { 'ok' }
child :data do
  node (:events_count) { @created_events.size }
  child @created_events do
    attributes :id,:user_id, :name, :description, :start_time, :end_time, :venue , :location
  end
end
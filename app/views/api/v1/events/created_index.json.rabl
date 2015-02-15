object false
node (:success) { true }
node (:info) { 'ok' }
child :data do
  node (:events_count) { @created_events.size }
  child @created_events do
    attributes :id, :user_id, :user_avatar, :name, :description, :start_time, :start_date, :location_name , :location_address, :datetime
  end
end
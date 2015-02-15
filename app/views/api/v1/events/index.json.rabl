object false
node (:success) { true }
node (:info) { 'ok' }
child :data do
  node (:events_count) { @invited_events.size }
  child @invited_events do
    attributes :id, :user_id, :user_avatar, :name, :description, :start_time, :start_date, :location_name , :location_address, :format_datetime
  end
end
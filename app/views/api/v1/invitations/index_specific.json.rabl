object false
node (:success) { true }
node (:info) { 'Loaded Invitation' }
child :data do
  child @invitation do
    attributes :id, :event_id, :user_id, :accepted
  end
end
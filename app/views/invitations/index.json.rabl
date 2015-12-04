object false
node (:success) { true }
node (:info) { 'ok' }
child :data do
  node (:invitations_count) { @invitations.size }
  child @invitations do
    attributes :id, :event_id, :user_id, :accepted
  end
end
object false
node (:success) { true }
node (:info) { 'Invitations Sent' }
child :data do
  child @task do
    attributes :id, :event_id, :user_id
  end
end
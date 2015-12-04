object false
node (:success) { true }
node (:info) { "You're In!" }
child :data do
  child @messages do
    attributes :id, :sender_username, :sender_avatar, :body, :formatted_updated_at
  end
end
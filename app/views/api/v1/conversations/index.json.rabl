object false
node (:success) { true }
node (:info) { "You're In!" }
child :data do
  child @conversations do
    attributes :id, :sender_id, :recipient_id, :other_user_avatar, :other_user_username, :last_message_body, :current_user_id, :formatted_updated_at
  end
end
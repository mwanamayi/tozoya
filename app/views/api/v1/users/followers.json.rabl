object false
node (:success) { true }
node (:info) { 'ok' }
child :data do
  node (:followers_count) { @followers.size }
  child @followers do
    attributes :id, :username
  end
end
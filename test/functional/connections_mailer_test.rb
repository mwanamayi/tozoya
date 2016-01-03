require 'test_helper'

class ConnectionsMailerTest < ActionMailer::TestCase
  test "accept_friend_request" do
    mail = ConnectionsMailer.accept_friend_request
    assert_equal "Accept friend request", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end

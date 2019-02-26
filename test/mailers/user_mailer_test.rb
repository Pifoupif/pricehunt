require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "alert_set" do
    mail = UserMailer.alert_set
    assert_equal "Alert set", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end

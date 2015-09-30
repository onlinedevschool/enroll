require "test_helper"

describe AcceptanceTeam do
  it "notify" do
    mail = AcceptanceTeam.notify
    value(mail.subject).must_equal "Notify"
    value(mail.to).must_equal ["to@example.org"]
    value(mail.from).must_equal ["from@example.com"]
    value(mail.body.encoded).must_match "Hi"
  end
end

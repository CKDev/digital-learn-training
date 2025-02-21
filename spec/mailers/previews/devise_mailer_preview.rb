class DeviseMailerPreview < ActionMailer::Preview
  def invitation_instructions
    user = User.last
    DeviseMailer.invitation_instructions(user, "foobar")
  end
end

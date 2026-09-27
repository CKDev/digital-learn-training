class DeviseMailerPreview < ActionMailer::Preview
  def invitation_instructions
    user = User.invite!(email: 'test_invite@example.com')
    DeviseMailer.invitation_instructions(user, 'foobar', organization: Organization.find_by(subdomain: 'att'))
  end
end

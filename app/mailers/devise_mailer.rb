class DeviseMailer < Devise::Mailer
  def invitation_instructions(record, token, opts = {})
    # We need a User <-> Organization relation
    # This is a hack for now, because the feature is only for AT&T
    @mailer_subdomain = 'att'
    super
  end
end
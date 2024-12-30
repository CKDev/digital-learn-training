class DeviseMailer < Devise::Mailer
  def invitation_instructions(record, token, opts = {})
    # We need a User <-> Organization relation
    # This is a hack for now, because the feature is only for AT&T
    att = Organization.find_by(subdomain: "att")
    @organization_subdomain = "att" # Logo subdomain
    @mailer_subdomain = SubdomainBuilder.new(att).build_subdomain # Link subdomain
    super
  end
end

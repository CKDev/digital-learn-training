class AdminMailer < ApplicationMailer
  def new_access_request(access_request_id)
    @access_request = AccessRequest.find(access_request_id)
    emails = @access_request.organization.access_request_emails
    return if (emails || []).empty?

    # Mailer layout variables
    # Note: The @mailer_subdomain isn't used for the access request link,
    # but it's used for the logo link from the mailer layout
    @organization_subdomain = @access_request.organization.subdomain # Logo prefix
    @mailer_subdomain = SubdomainBuilder.new(att).build_subdomain # Link subdomain
    subject = "New DigitalLearn Collaborator Access Request"
    mail(to: emails, subject: subject)
  end
end
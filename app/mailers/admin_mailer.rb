class AdminMailer < ApplicationMailer
  def new_access_request(access_request_id)
    @access_request = AccessRequest.find(access_request_id)
    organization = @access_request.organization
    emails = organization.access_request_emails
    return if (emails || []).empty?

    @organization_subdomain = @access_request.organization.subdomain # Logo prefix
    @mailer_subdomain = SubdomainBuilder.new(organization).build_subdomain # Link subdomain

    subject = "New DigitalLearn Collaborator Access Request"
    mail(to: emails, subject: subject)
  end
end
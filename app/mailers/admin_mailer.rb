class AdminMailer < ApplicationMailer
  def new_access_request(access_request_id)
    @access_request = AccessRequest.find(access_request_id)
    emails = @access_request.organization.access_request_emails
    @mailer_subdomain = SubdomainBuilder.new(@access_request.organization).build_subdomain
    return unless email.present?
    subject = "New DigitalLearn Collaborator Access Request"
    mail(to: emails, subject: subject)
  end
end
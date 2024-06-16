class AdminMailer < ApplicationMailer
  def new_access_request(access_request_id)
    @access_request = AccessRequest.find(access_request_id)
    email = @access_request.organization.access_request_email
    @mailer_subdomain = @access_request.organization.subdomain
    return unless email.present?
    subject = "New DigitalLearn Collaborator Access Request"
    mail(to: email, subject: subject)
  end
end
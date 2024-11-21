# Preview all emails at http://localhost:3000/rails/mailers/admin_mailer

class AdminMailerPreview < ActionMailer::Preview
  def new_access_request
    access_request = AccessRequest.first

    if access_request.blank?
      att = Organization.find_by_subdomain("att")
      access_request = FactoryBot.create(:access_request, organization: att)
    end

    AdminMailer.new_access_request(access_request.id)
  end
end

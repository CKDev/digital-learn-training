# Initialize ActionMailer settings for sendgrid
login = Rails.application.credentials[Rails.env.to_sym][:sendgrid_login]
password = Rails.application.credentials[Rails.env.to_sym][:sendgrid_password]
domain = Rails.application.credentials[Rails.env.to_sym][:sendgrid_domain] || "commercekitchen.com"

if login.nil? && password.nil?
  abort "Please ensure the sendgrid_login and sendgrid_password are defined in secrets.yml"
else
  ActionMailer::Base.smtp_settings = {
    user_name: login,
    password: password,
    domain: domain,
    address: "smtp.sendgrid.net",
    port: 587,
    authentication: :plain,
    enable_starttls_auto: true
  }
end

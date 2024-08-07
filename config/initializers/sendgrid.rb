# Initialize ActionMailer settings for sendgrid
api_key = Rails.application.credentials.dig(Rails.env.to_sym, :sendgrid_api_key)
domain = Rails.application.credentials.dig(Rails.env.to_sym, :sendgrid_domain) || "commercekitchen.com"

if api_key.nil?
  abort "Please ensure the sendgrid_api_key is defined in credentials file"
else
  ActionMailer::Base.smtp_settings = {
    from: 'no-reply@digitallearn.org',
    user_name: 'apikey',
    password: api_key,
    domain: domain,
    address: "smtp.sendgrid.net",
    port: 587,
    authentication: :plain,
    enable_starttls_auto: true
  }
end

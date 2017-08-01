require "rails_helper"
require "capybara/rails"
require "capybara/rspec"

def log_in_with(email, password)
  visit new_session_path
  find("#user_email").set(email)
  find("#user_password").set(password)
  click_button "Let's Go!"
end

def log_in(user)
  # visit root_path # There is no login on the public homepage.  TODO: revisit this
  # click_link "Log In"
  visit new_user_session_path
  find("#user_email", visible: false).set(user.email)
  find("#user_password", visible: false).set(user.password)
  click_button "Log In"
end

def log_out
  click_link "Sign Out"
end

def assert_no_alerts(types = [:alert, :confirm, :prompt])
  types.each do |type|
    alerts = page.driver.send(:"#{type}_messages")
    expect(alerts.size).to eq 0
  end
end

Capybara.javascript_driver = :webkit
# Capybara.javascript_driver = :selenium
Capybara::Webkit.configure do |config|
  # config.debug = true # Uncomment for error information.
  config.allow_url("cdn-images.mailchimp.com")
end

Capybara.configure do |config|
  config.always_include_port = true
end

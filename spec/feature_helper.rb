require "rails_helper"
require "capybara/rails"
require "capybara/rspec"
require 'webmock/rspec'

def log_in_with(email, password)
  visit new_session_path
  find("#user_email").set(email)
  find("#user_password").set(password)
  click_button "Let's Go!"
end

def log_in(user)
  visit new_user_session_path
  find("#user_email", visible: false).set(user.email)
  find("#user_password", visible: false).set(user.password)
  click_button "Log In"
end

def log_out
  click_link "Sign Out"
end

def alert_present?
  alert = driver.switch_to.alert
  return true
rescue
  return false
end


def switch_to_subdomain(subdomain, tld = nil)
  # lvh.me always resolves to 127.0.0.1
  tld ||= 'lvh.me'
  host = subdomain ? "#{subdomain}.#{tld}" : tld
  Capybara.app_host = "http://#{host}"
end

def reset_subdomain
  Capybara.app_host = nil
end

Capybara.server = :webrick

# Use Selenium and Chromedriver for feature specs
Capybara.javascript_driver = :selenium_chrome_headless

# Configure webmock to disallow network connections
WebMock.disable_net_connect!({ allow_localhost: true,
                               allow: 'chromedriver.storage.googleapis.com' })


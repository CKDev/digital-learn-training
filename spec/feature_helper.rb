require "rails_helper"
require "capybara/rails"
require "capybara/rspec"
require 'selenium/webdriver'

Capybara.register_driver :selenium_headless do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--headless')
  options.add_argument('--disable-gpu')
  options.add_argument('--no-sandbox')
  options.add_argument('--window-size=1920,1400')

  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

Capybara.default_driver = :rack_test
Capybara.javascript_driver = :selenium_headless

RSpec.configure do |config|
  config.before(:each, type: :system) { driven_by Capybara.default_driver }

  config.before(:each, type: :system, js: true) do
    driven_by Capybara.javascript_driver
    Capybara.current_session.driver.browser.manage.delete_all_cookies

    # Use capybara host & port in url helpers
    Rails.application.routes.default_url_options[:host] = Capybara.current_session.server.host
    Rails.application.routes.default_url_options[:port] = Capybara.current_session.server.port
  end
end

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
  driver.switch_to.alert
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


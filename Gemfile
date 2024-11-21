source "https://rubygems.org"

gem "rails", "~> 7.1.4"
gem "pg"
gem "puma"
gem "sass-rails"
gem "coffee-rails"
gem "uglifier", ">= 1.3.0"
gem "jquery-rails"
gem "sidekiq", "< 8"
gem "recaptcha", "~> 5.16"
gem "net-http"

# Use Redis adapter to run Action Cable in production
gem "redis"
gem "redis-namespace"

# Authentication and authorization
gem "devise"

# SAML authentication
gem "devise_saml_authenticatable", "~> 1.6.3"

# Bourbon for sass mixins, and neat for the grid framework
# gem "bourbon", "4.3.4"
# gem "neat", "1.9.0" # Careful, as v2.0 removes some mixins in use.

# Reporting tools
gem "rollbar"

# File uploads
gem "kt-paperclip"

gem "rubyzip", require: "zip" # ASL files

# PDF generation for completion certificate
gem "wicked_pdf"
gem "wkhtmltopdf-binary"

# Misc
gem "local_time" # Client-side timezone rendering
gem "friendly_id" # Slugs for urls
gem "ckeditor", "~> 4.3.0" # HTML Editor
gem "cocoon" # Dynamic forms for has-many relationships

gem "rack-attack" # Prevent botspam and allow white/blacklisting IPs, etc

# AWS sdk for s3
gem "aws-sdk-s3", "~>1"

# Rack::Proxy for S3 Proxy middleware
gem "rack-proxy"

# Data migrations
gem "data_migrate", "~>9.2.0"

# Invitations
gem "devise_invitable", "~> 2.0.0"

group :development, :test do
  gem "pry"
  gem "pry-byebug"
  gem "awesome_print"
  gem "bullet"
  gem "listen" # Required by Rails
  gem "rspec-rails"
  gem "faker"
end

group :development do
  gem "rubocop", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-rspec", require: false
  gem "brakeman", require: false
  gem "foreman", require: false
  gem "letter_opener"
  gem "web-console"
  gem "colorize" # For colored spec/capybara output
end

group :test do
  gem "factory_bot_rails"
  gem "rails-controller-testing"
  gem "capybara"
  gem "selenium-webdriver", "~> 4.0"
  gem "mocha"
  gem "simplecov", require: false
  gem "timecop"
end

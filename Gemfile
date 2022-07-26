source "https://rubygems.org"

gem "rails", "5.2.8"
gem "pg", "~> 0.18"
gem "puma"
gem "sass-rails"
gem "coffee-rails"
gem "uglifier", ">= 1.3.0"
gem "jquery-rails"

# Use Redis adapter to run Action Cable in production
gem "redis", "~> 3.0"
gem "redis-namespace"

# Authentication and authorization
gem "devise"

# SAML authentication
gem 'devise_saml_authenticatable', '~> 1.6.3'

# Bourbon for sass mixins, and neat for the grid framework
gem "bourbon", "4.2.7"
gem "neat", "1.8.0" # Careful, as v2.0 removes some mixins in use.

# Reporting tools
gem "rollbar"

# File uploads
gem "paperclip"

gem "rubyzip" # ASL files

# API Requests and Caching
gem "api_cache"
gem "moneta"

# PDF generation for completion certificate
gem "wicked_pdf"
gem "wkhtmltopdf-binary"

# Misc
gem "local_time" # Client-side timezone rendering
gem "friendly_id" # Slugs for urls
gem "ckeditor" # HTML Editor
gem "cocoon" # Dynamic forms for has-many relationships

gem "rack-attack" # Prevent botspam and allow white/blacklisting IPs, etc

# AWS sdk for s3
gem 'aws-sdk-s3', '~>1'

# Rack::Proxy for S3 Proxy middleware
gem 'rack-proxy'

# Resize images for ActiveStorage
gem 'mini_magick'

group :development, :test do
  gem "pry"
  gem "pry-byebug"
  gem "awesome_print"
  gem "bullet"
  gem "listen" # Required by Rails
  # gem "httplog"
  gem "rspec-rails", "~> 5.0.0"
end

group :development do
  gem "rubocop", require: false
  gem "brakeman", require: false
  gem "foreman", require: false
  # gem "rack-mini-profiler"
  gem "letter_opener"
  gem "web-console"
  gem "colorize" # For colored spec/capybara output
end

group :test do
  gem "factory_bot_rails"
  gem "rails-controller-testing"
  gem "capybara"
  gem "webdrivers"
  gem "database_cleaner"
  gem "launchy"
  gem "mocha"
  gem "simplecov", require: false
  gem "timecop"
  gem "webmock"
end

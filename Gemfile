source "https://rubygems.org"

gem "rails", "5.1.2"
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

# Bourbon for sass mixins, and neat for the grid framework
gem "bourbon", "4.2.7"
gem "neat", "1.8.0" # Careful, as v2.0 removes some mixins in use.

# Background processing
# gem "sidekiq"
# gem "sinatra", require: nil # For the Sidekiq web interface
# gem "sidekiq-failures"

# Reporting tools
gem "rollbar"
# gem "skylight"

gem "paperclip", "~> 4.3" # File uploads
gem "rubyzip" # ASL files
# gem "fog-aws"
# gem "mini_magick"
# gem "file_validators" # For image validation

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
# gem "whenever", require: false # Cron scheduling
# gem "will_paginate"

group :development, :test do
  gem "pry"
  gem "pry-byebug"
  gem "awesome_print", require: "ap"
  gem "bullet"
  gem "rspec-rails" # This needs to be here for the rake tasks to work.
  gem "listen" # Required by Rails
  # gem "httplog"
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
  gem "factory_girl_rails"
  gem "rails-controller-testing"
  gem "capybara-webkit"
  gem "selenium-webdriver"
  gem "database_cleaner"
  gem "launchy"
  gem "mocha"
  gem "simplecov", require: false
  gem "timecop"
  gem "rspec-sidekiq"
  # gem "webmock"
end

# Capistrano Deployment
group :development, :deployment do
  gem "capistrano", "3.4.0", require: false # Deploy is locked to this version.
  gem "capistrano-rails", "~> 1.1.3", require: false
  gem "capistrano-rvm", require: false
  gem "capistrano-faster-assets", "~> 1.0", require: false
  gem "capistrano-db-tasks", "~> 0.4", require: false
  gem "capistrano3-puma", require: false
  gem "capistrano-bundler", require: false
  gem "capistrano-sidekiq", require: false
end

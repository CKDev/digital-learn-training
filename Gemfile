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
# gem "rolify"
# gem "pundit"

# Background processing
# gem "sidekiq"
# gem "sinatra", require: nil # For the Sidekiq web interface
# gem "sidekiq-failures"

# Reporting tools
# gem "rollbar"
# gem "skylight"

# File uploads to S3
# gem "carrierwave"
# gem "fog-aws"
# gem "mini_magick"
# gem "file_validators" # For image validation

# Misc
gem "local_time" # Client-side timezone rendering
# gem "geocoder" # Convert addresses into lat/long
# gem "whenever", require: false # Cron scheduling
# gem "paper_trail" # Model auditing
# gem "will_paginate"

group :development, :test do
  gem "pry"
  gem "pry-byebug"
  gem "awesome_print", require: "ap"
  gem "bullet"
  gem "rspec-rails" # This needs to be here for the rake tasks to work.
  # gem "httplog"
end

group :development do
  gem "rubocop", require: false
  gem "brakeman", require: false
  gem "foreman", require: false
  gem "rack-mini-profiler"
  gem "letter_opener"
  gem "web-console", "~> 2.0"
  gem "listen", "~> 3.0.5"
  gem "colorize" # For colored spec/capybara output
  # gem "quiet_assets"
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
  gem "capistrano3-puma",   require: false
  gem "capistrano-bundler", require: false
  # gem "capistrano-sidekiq", require: false
end

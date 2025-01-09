require "active_support/core_ext/integer/time"

# Enable S3
# require File.expand_path('../../s3_enabled_environment', __FILE__)

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded any time
  # it changes. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Serve static assets
  config.serve_static_assets = true

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  # Run rails dev:cache to toggle caching.
  if Rails.root.join('tmp', 'caching-dev.txt').exist?
    config.action_controller.perform_caching = true
    config.action_controller.enable_fragment_cache_logging = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Email settings
  config.action_mailer.default_url_options = { host: "localhost", port: 3000, only_path: false }
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :letter_opener
  config.action_mailer.perform_caching = false
  # config.action_mailer.delivery_method = :smtp

  # To use url helpers in workers
  Rails.application.routes.default_url_options = { host: "localhost", port: 3000, only_path: false }

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise exceptions for disallowed deprecations.
  config.active_support.disallowed_deprecation = :raise

  # Tell Active Support which deprecation messages to disallow.
  config.active_support.disallowed_deprecation_warnings = []

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # Raises error for missing translations.
  config.i18n.raise_on_missing_translations = true

  # Annotate rendered view with file names.
  # config.action_view.annotate_rendered_view_with_filenames = true

  config.hosts << /[a-z0-9]+\.lvh\.me/
  config.hosts << "lvh.me:4000"
  config.hosts << "tomreis.ngrok.io"

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  # Uncomment if you wish to allow Action Cable access from any origin.
  # config.action_cable.disable_request_forgery_protection = true

  # Bullet config
  config.after_initialize do
    Bullet.enable = false
    Bullet.console = true
    Bullet.rails_logger = true
    Bullet.add_footer = true
  end

  # S3 Overrides
  config.s3_enabled = false

  # Store uploaded files on the local file system (see config/storage.yml for options).
  # config.active_storage.service = :local
  
  # Learners site url host
  config.learners_site_host = 'lvh.me:3000'
end

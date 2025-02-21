require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DigitalLearnTraining
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    config.active_support.cache_format_version = 7.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.i18n.load_path += Dir[Rails.root.join("config", "locales", "**", "*.{rb,yml}")]

    Paperclip.options[:content_type_mappings] = { story:  %w(application/octet-stream application/zip) }

    # Use routing for error pages
    config.exceptions_app = self.routes

    # Default paperclip options
    config.paperclip_defaults = {
      storage: :filesystem,
      path: ":rails_root/public/:url",
    }

    # Storyline paperclip options
    config.storyline_paperclip_opts = {
      path: ":rails_root/public/system:url",
      url: "/lessons/storylines/:id/:style/:basename.:extension"
    }

    # Sidekiq for job processing
    config.active_job.queue_adapter = :sidekiq
  end
end

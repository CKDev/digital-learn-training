require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DigitalLearnTraining
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.i18n.load_path += Dir[Rails.root.join("config", "locales", "**", "*.{rb,yml}")]

    Paperclip.options[:content_type_mappings] = { story:  %w(application/octet-stream application/zip) }

    # Use routing for error pages
    config.exceptions_app = self.routes

    # S3 configuration
    config.s3_enabled = true
    config.s3_bucket_name = "dl-training-uploads-#{Rails.env}"
    config.s3_region = "us-west-2"

    config.paperclip_defaults = {
      storage: :s3,
      bucket: config.s3_bucket_name,
      s3_region: config.s3_region,
      s3_host_name: "s3-#{config.s3_region}.amazonaws.com"
    }


    config.zipped_storyline_bucket_name = "dl-training-storylines-#{Rails.env}-zipped"
    config.storyline_bucket_name = "dl-training-storylines-#{Rails.env}"

    config.storyline_paperclip_opts = config.paperclip_defaults.merge({
      bucket: config.zipped_storyline_bucket_name,
      url: "storylines/:id/:basename.:extension"
    })
  end
end

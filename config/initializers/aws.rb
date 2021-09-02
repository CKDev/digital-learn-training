if Rails.application.config.s3_enabled
  Aws.config = {
    region: Rails.application.config.s3_region
  }
end

module DigitalLearnTraining
  class Application < Rails::Application
    # Proxy requests to /storyines to S3 bucket
    require Rails.root.join("lib/s3_proxy.rb")
    config.middleware.use S3Proxy, streaming: false
  
    # S3 configuration
    config.s3_enabled = true
    config.s3_bucket_name = "dl-training-uploads-#{Rails.env}"
    config.s3_region = "us-west-2"

    config.paperclip_defaults = {
      path: ":url",
      storage: :s3,
      bucket: config.s3_bucket_name,
      s3_region: config.s3_region,
      s3_host_name: "s3-#{config.s3_region}.amazonaws.com",
      s3_protocol: :https
    }

    config.zipped_storyline_bucket_name = "dl-training-storylines-#{Rails.env}-zipped"
    config.storyline_bucket_name = "dl-training-storylines-#{Rails.env}"

    config.storyline_paperclip_opts = config.paperclip_defaults.merge({
      bucket: config.zipped_storyline_bucket_name,
      url: "storylines/:id/:basename.:extension"
    })
  end
end

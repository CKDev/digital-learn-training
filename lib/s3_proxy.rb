# frozen_string_literal: true

require 'rack-proxy'

class S3Proxy < Rack::Proxy
  def perform_request(env)
    request = Rack::Request.new(env)

    # use rack proxy for anything hitting our host app at /example_service
    if use_s3? && request.path =~ %r{^/storylines}
      @backend = URI("https://#{s3_bucket_name}.s3-#{s3_region}.amazonaws.com")

      # most backends required host set properly, but rack-proxy doesn't set this for you automatically
      # even when a backend host is passed in via the options
      env['HTTP_HOST'] = @backend.host

      # This is the only path that needs to be set currently on Rails 5 & greater
      env['PATH_INFO'] = request.fullpath

      # don't send your sites cookies to target service, unless it is a trusted internal service that can parse all your cookies
      env['HTTP_COOKIE'] = ''

      super
    else
      @app.call(env)
    end
  end

  private

  def use_s3?
    Rails.configuration.s3_enabled
  end

  def s3_bucket_name
    Rails.configuration.storyline_bucket_name
  end

  def s3_region
    Rails.configuration.s3_region
  end
end

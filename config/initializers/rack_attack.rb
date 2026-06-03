# frozen_string_literal: true

Rack::Attack.cache.store = ActiveSupport::Cache::RedisCacheStore.new(
  url: "redis://#{ENV['REDIS_HOST']}:#{ENV['REDIS_PORT']}/1"
) if ENV['REDIS_HOST'].present?

class Rack::Attack
  # In test, rack-attack can make request specs flaky/noisy.
  unless Rails.env.test?

    # ----------------------------
    # Helpers (safe / non-parsing)
    # ----------------------------

    BAD_ROUTES = %w[
      /wp-login.php
      /oneshotimage1
      /clientaccesspolicy.xml
      /mysql/admin
      /recordings/theme/main.css
      /wp-admin
      /wp-content
      /wp-includes
      /xmlrpc.php
      /.env
      /config.php
      /setup.php
      /servlet/
      /invoker/
      /jmx-console
      /web-console
      /manager/html
      /shell
      /cmd
      /exec
      /.git/
      /.aws/
      /.ssh/
      /etc/passwd
      /proc/self
      /phpmyadmin
      /pma
      /myadmin
      /.ht
      /actuator
      /backup
      /db/
      /database/
      /console
    ].freeze

    LEGACY_CRED_KEYS = %w[cmd passwd username].freeze

    def self.safe_params(req)
      # Accessing req.params / req.POST can raise on malformed multipart requests.
      # We only need params for a couple of checks; fail closed by returning {}.
      req.params
    rescue Rack::Multipart::EmptyContentError
      {}
    rescue => e
      # Don't let unexpected parser errors take down middleware.
      Rails.logger.warn("[Rack::Attack] params parse failed: #{e.class}: #{e.message}")
      {}
    end

    def self.safe_login_email(req)
      p = safe_params(req)

      # Devise common shapes:
      # - params["email"]
      # - params["user"]["email"]
      email = p["email"] || p.dig("user", "email")
      email.to_s.strip.downcase.presence
    end

    def self.form_key_present?(req, keys)
      p = safe_params(req)
      keys.any? { |k| p.key?(k) }
    end

    # ----------------------------
    # Throttles
    # ----------------------------

    throttle("req/ip", limit: 300, period: 5.minutes) { |req| req.ip }

    throttle("logins/ip", limit: 5, period: 20.seconds) do |req|
      req.ip if req.post? && req.path == "/users/sign_in"
    end

    throttle("logins/email", limit: 5, period: 20.seconds) do |req|
      safe_login_email(req) if req.post? && req.path == "/users/sign_in"
    end

    throttle("posts/ip", limit: 20, period: 1.minute) do |req|
      # Optional: skip known endpoints that legitimately post frequently (AJAX polling etc.)
      req.ip if req.post?
    end

    # ----------------------------
    # Blocklists (explicit)
    # ----------------------------

    # Auto-ban IPs that repeatedly trip any probe/scanner rule.
    # After 5 violations within 10 minutes, banned for 24 hours.
    # Requires Rack::Attack.cache.store to be a shared store (e.g. Redis) in production.
    blocklist("bad-actor ban") do |req|
      Rack::Attack::Allow2Ban.filter("bad-actor:#{req.ip}", maxretry: 5, findtime: 10.minutes, bantime: 24.hours) do
        BAD_ROUTES.any? { |r| req.path.start_with?(r) } ||
          req.path.end_with?(".php", ".asp", ".aspx", ".jsp", ".cgi", ".env", ".sql", ".bak", ".zip", ".tar", ".gz") ||
          req.user_agent.nil?
      end
    end

    # Honeypot route for bots/researchers
    blocklist("honeypot trap") { |req| req.path == "/admin/login" }

    # Never-valid routes that generate noise (WordPress probes etc.)
    blocklist("bad routes") { |req| BAD_ROUTES.any? { |r| req.path.start_with?(r) } }

    # Block suspicious "old admin panel" credential keys (without exploding on bad multipart)
    blocklist("legacy credential param attempts") do |req|
      req.post? && req.form_data? && form_key_present?(req, LEGACY_CRED_KEYS)
    end

    # Block common attack vectors by file extension (without exploding on bad multipart)
    blocklist("bad extensions") do |req|
      req.path.end_with?(".php", ".asp", ".aspx", ".jsp", ".cgi", ".env", ".sql", ".bak", ".zip", ".tar", ".gz")
    end

    # Real browsers should always have a user agent string.
    blocklist("scanner user agents") do |req|
      req.user_agent.nil?
    end

    # ----------------------------
    # Logging / instrumentation
    # ----------------------------

    ActiveSupport::Notifications.subscribe("rack.attack") do |_name, _start, _finish, _request_id, payload|
      req = payload[:request]
      match_type = payload[:match_type] # :blocklist or :throttle
      rule = payload[:matched]          # name of the matched rule

      # Don't touch req.params here (can trigger multipart parsing + may log secrets)
      Rails.logger.warn(
        "[Rack::Attack] #{match_type} rule=#{rule.inspect} ip=#{req.ip} method=#{req.request_method} path=#{req.fullpath} ua=#{req.user_agent.to_s.tr("\n", " ")}"
      )
    end
  end
end

# frozen_string_literal: true

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
    ].freeze

    LEGACY_CRED_KEYS = %w[cmd passwd username].freeze

    SUSPICIOUS_UA_SUBSTRINGS = %w[
      python-requests
      httpclient
    ].freeze

    def self.safe_params(req)
      # Accessing req.params / req.POST can raise on malformed multipart requests.
      # We only need params for a couple of checks; fail closed by returning {}.
      req.params
    rescue Rack::Multipart::EmptyContentError, Rack::Multipart::BoundaryError
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

    # Honeypot route for bots/researchers
    blocklist("honeypot trap") { |req| req.path == "/admin/login" }

    # Never-valid routes that generate noise (WordPress probes etc.)
    blocklist("bad routes") { |req| BAD_ROUTES.include?(req.path) }

    # Block suspicious "old admin panel" credential keys (without exploding on bad multipart)
    blocklist("legacy credential param attempts") do |req|
      req.post? && req.form_data? && form_key_present?(req, LEGACY_CRED_KEYS)
    end

    # User-Agent blocklist: keep it narrow to obvious automated tooling.
    # NOTE: Blocking "curl" broadly can block legitimate internal checks.
    blocklist("suspicious user agents") do |req|
      ua = req.user_agent.to_s.downcase
      SUSPICIOUS_UA_SUBSTRINGS.any? { |s| ua.include?(s) }
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

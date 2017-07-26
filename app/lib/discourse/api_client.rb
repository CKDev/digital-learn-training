module Discourse
  module ApiClient

    COP_BASE_URL = "http://community.projectoutcome.org".freeze

    def faraday_connection
      @conn ||= Faraday.new(url: COP_BASE_URL)
    end

    def topics
      response = faraday_connection.get(
        "/latest.json"
      )
      parse_response(response)["topic_list"]["topics"]
    end

    def get_user(username)
      response = faraday_connection.get(
        "/users/#{username}.json"
      )
      parse_response(response)["user"]
    end

    def cop_link(path)
      "#{COP_BASE_URL}#{path}"
    end

    def valid_json?(json)
      JSON.parse(json)
      true
    rescue JSON::ParserError
      false
    end

    def parse_response(resp)
      if resp.body && valid_json?(resp.body)
        JSON.parse(resp.body)
      elsif resp.body && !valid_json?(resp.body)
        resp.body
      else
        resp
      end
    end

  end
end

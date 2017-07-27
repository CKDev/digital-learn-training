module Discourse
  module ApiClient

    COP_BASE_URL = "http://community.digitallearn.org".freeze

    def topics
      response = APICache.get("#{COP_BASE_URL}/latest.json")
      parse_response(response)["topic_list"]["topics"]
    end

    def get_user(username)
      response = APICache.get("#{COP_BASE_URL}/users/#{username}.json")
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
      if resp && valid_json?(resp)
        JSON.parse(resp)
      else
        resp
      end
    end

  end
end

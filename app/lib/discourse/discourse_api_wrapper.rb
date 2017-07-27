module Discourse
  class DiscourseApiWrapper
    include Discourse::ApiClient

    def initialize
    end

    def recent_topics
      @recent_topics ||= topics.lazy
        .reject { |topic| topic["pinned"] }
        .first(3)
        .map(&method(:klassify))
    rescue => e
      Rails.logger.error e.message # TODO: Log to Rollbar?
      []
    end

    private

    def klassify(hash_object)
      Discourse::Topic.new(hash_object)
    end

  end
end

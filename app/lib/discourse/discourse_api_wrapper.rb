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
    end

    private

    def klassify(hash_object)
      Discourse::Topic.new(hash_object)
    end

  end
end

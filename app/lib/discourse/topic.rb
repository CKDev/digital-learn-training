module Discourse
  class Topic
    include Discourse::ApiClient

    def initialize(topic_hash)
      @topic = OpenStruct.new(topic_hash)
    end

    def url
      cop_link("/t/#{@topic['slug']}/#{@topic['id']}")
    end

    def last_poster_url
      cop_link("/users/#{@topic['last_poster_username']}/activity")
    end

    def last_poster_avatar
      init_user
      avatar_template = @user["avatar_template"]
      avatar_template.gsub!(/{size}/, "25")
      return avatar_template if avatar_template.match("avatars.discourse")
      cop_link(avatar_template)
    end

    def bumped_at
      Date.strptime(@topic.bumped_at).strftime("%m/%d/%Y")
    end

    def method_missing(sym, *args, &block)
      return @topic.send(sym) if @topic.respond_to?(sym)
      super
    end

    private

    def init_user
      @user ||= get_user(@topic["last_poster_username"])
    end

  end
end

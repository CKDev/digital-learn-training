class HomeController < ApplicationController

  def index
    @recent_topics = discourse_wrapper.recent_topics
    @courses = Course.published.alpha_order
  end

  private

  def discourse_wrapper
    @discourse_wrapper ||= Discourse::DiscourseApiWrapper.new
  end

end

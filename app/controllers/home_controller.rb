class HomeController < ApplicationController

  def index
    @recent_topics = discourse_wrapper.recent_topics
    @courses = Course.published.limit(2)
    @course_materials = CourseMaterial.all # TODO: limit to published
  end

  private

  def discourse_wrapper
    @discourse_wrapper ||= Discourse::DiscourseApiWrapper.new
  end

end

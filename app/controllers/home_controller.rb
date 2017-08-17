class HomeController < ApplicationController

  def index
    @recent_topics = discourse_wrapper.recent_topics
    @courses = Course.published.limit(2)
    @course_materials = CourseMaterial.all # TODO: limit to published
    @categories = Category.includes(sub_categories: :course_materials).all
  end

  private

  def discourse_wrapper
    @discourse_wrapper ||= Discourse::DiscourseApiWrapper.new
  end

end

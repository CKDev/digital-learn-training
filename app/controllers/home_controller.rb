class HomeController < ApplicationController

  def index
    @recent_topics = discourse_wrapper.recent_topics
    @courses = Course.published.limit(2)
    @course_materials = CourseMaterial.all # TODO: limit to published
    @categories = Category.includes(sub_categories: :course_materials).all
    @hardware = @categories.where(tag: "Hardware")
    @software_and_applications = @categories.where(tag: "Software & Applications")
    @job_and_career = @categories.where(tag: "Job & Career")
  end

  private

  def discourse_wrapper
    @discourse_wrapper ||= Discourse::DiscourseApiWrapper.new
  end

end

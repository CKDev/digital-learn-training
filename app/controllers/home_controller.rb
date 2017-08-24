class HomeController < ApplicationController

  def index
    @recent_topics = discourse_wrapper.recent_topics
    @courses = Course.published.limit(2)
    @categories = Category.includes(sub_categories: :course_materials).all
    @hardware = @categories.where(tag: "Hardware")
    @software_and_applications = @categories.where(tag: "Software & Applications")
    @job_and_career = @categories.where(tag: "Job & Career")
    @blank_template = CourseMaterial.find_by(title: "Course Templates")
  end

  private

  def discourse_wrapper
    @discourse_wrapper ||= Discourse::DiscourseApiWrapper.new
  end

end

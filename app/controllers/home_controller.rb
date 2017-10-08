class HomeController < ApplicationController

  def index
    @courses = Course.published.limit(2)
    @categories = Category.includes(sub_categories: :course_materials).all
    @getting_started = @categories.where(tag: "Getting Started")
    @hardware = @categories.where(tag: "Hardware")
    @software_and_applications = @categories.where(tag: "Software & Applications")
    @job_and_career = @categories.where(tag: "Job & Career")
    @blank_template = CourseMaterial.find_by(title: "Course Templates")
  end

end

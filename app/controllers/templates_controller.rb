class TemplatesController < ApplicationController
  before_action :include_user_sidebar

  def index
    @course_template_course = CourseMaterial.find_by(title: "Course Templates")

    if @course_template_course.blank?
      redirect_to root_path
    end
  end
end

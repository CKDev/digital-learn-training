class CourseMaterialsController < ApplicationController

  def index
    @categories = get_categories
    @getting_started = @categories.where(tag: "Getting Started")
    @hardware = @categories.where(tag: "Hardware")
    @software_and_applications = @categories.where(tag: "Software & Applications")
    @job_and_career = @categories.where(tag: "Job & Career")
    @blank_template = CourseMaterial.find_by(title: "Course Templates")
  end

  def show
    @course_material = CourseMaterial.published.friendly.find(params[:id])
    @course_materials = CourseMaterial
      .published
      .not_self(@course_material.id)
      .in_category(@course_material.category.id)
      .in_language(current_language)
      .limit(3)
  end

  private

  def get_categories
    categories = current_organization ? Category.where(organization: current_organization) : Category.where(organization: nil)

    categories.includes(sub_categories: :course_materials)
  end
end

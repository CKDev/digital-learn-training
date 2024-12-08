class CourseMaterialsController < ApplicationController

  def index
    @categories = categories
    @blank_template = CourseMaterial.find_by(title: "Course Templates")

    @course_materials_data = {
      categories: @categories.map(&:to_props)
    }
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

  def categories
    categories = current_organization ? Category.where(organization: current_organization) : Category.where(organization: nil)

    categories.includes(sub_categories: :course_materials)
  end
end

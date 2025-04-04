class CourseMaterialsController < ApplicationController
  before_action :include_user_sidebar, only: :index

  def index
    if current_organization.blank? && !@use_ui_v2
      redirect_to root_path
    end

    @categories = categories.with_published_course_materials
    @blank_template = CourseMaterial.find_by(title: 'Course Templates')

    categories_data = @categories.map { |c| c.to_props(include_materials: true) }

    @course_materials_data = {
      categories: categories_data + imported_categories_data,
      initialCategoryFriendlyId: params[:category],
      initialLanguage: params[:language]
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

  def imported_categories_data
    return [] unless current_organization&.can_import_courses?

    current_organization.imported_course_materials.group_by(&:category_id).map do |category_id, course_materials|
      category = Category.find(category_id)
      category.to_props.merge(courseMaterials: course_materials.map(&:to_props))
    end
  end
end

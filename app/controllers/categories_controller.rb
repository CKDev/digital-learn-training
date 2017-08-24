class CategoriesController < ApplicationController

  def show
    @category = Category.find(params[:id])
    @course_materials = CourseMaterial.published.in_category(@category.id).where(sub_category_id: nil)
    @sub_categorized_course_materials = CourseMaterial.published.in_category(@category.id).where.not(sub_category_id: nil)
  end

end

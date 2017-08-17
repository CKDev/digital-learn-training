class CategoriesController < ApplicationController

  def show
    @category = Category.find(params[:id])
    @course_materials = CourseMaterial.in_category(@category.id)
  end

end

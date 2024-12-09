class CategoriesController < ApplicationController
  before_action :include_user_sidebar

  def show
    @category = Category.friendly.find(params[:id])
    @course_materials = CourseMaterial
                          .published
                          .in_category(@category.id)
                          .in_language(current_language)
                          .where(sub_category_id: nil)
    @sub_categorized_course_materials = CourseMaterial
                                          .published
                                          .in_category(@category.id)
                                          .in_language(current_language)
                                          .where.not(sub_category_id: nil)
  end

end

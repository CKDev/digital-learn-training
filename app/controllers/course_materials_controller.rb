class CourseMaterialsController < ApplicationController

  def show
    @course_material = CourseMaterial.not_archived.find(params[:id])
    @course_materials = CourseMaterial
      .not_archived
      .not_self(@course_material.id)
      .in_category(@course_material.category.id)
      .limit(3)
  end

end

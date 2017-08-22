class CourseMaterialsController < ApplicationController

  def show
    @course_material = CourseMaterial.find(params[:id])
    # TODO: below, not self.
    @course_materials = CourseMaterial.in_category(@course_material.category.id).limit(3)
  end

end

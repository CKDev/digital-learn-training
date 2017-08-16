class CourseMaterialsController < ApplicationController

  def show
    @course_material = CourseMaterial.find(params[:id])
  end

end

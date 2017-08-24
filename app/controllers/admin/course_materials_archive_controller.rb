module Admin
  class CourseMaterialsArchiveController < BaseController

    def index
      @course_materials = CourseMaterial.archived.order(:title)
    end

    # In this case, destroy from the archive, which moves it back to the standard list.
    def destroy
      @course_material = CourseMaterial.find(params[:id])
      if @course_material.update(archived: false)
        redirect_to admin_course_materials_path, notice: "Successfully un-archived Course"
      else
        redirect_to admin_course_materials_path, alert: "Unable to un-archive Course"
      end
    end

  end
end

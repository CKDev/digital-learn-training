module Admin
  class CourseMaterialsArchiveController < BaseController

    def index
      @course_materials = CourseMaterial.archived.order(:title)
    end

  end
end

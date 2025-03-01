module Admin
  class CourseMaterialImportsController < BaseController
    def index
      @course_materials = CourseMaterial.for_organization(nil) # Only "main site" materials are currently importable
      @imported_course_materials = current_organization.imported_course_materials
    end

    def create
      course_material = CourseMaterial.find(params[:course_material_id])
      if current_organization.imported_course_materials << course_material
        render json: { message: 'Course imported successfully' }, status: :created
      else
        render json: { error: 'Error importing course' }, status: :unprocessable_entity
      end
    end

    def destroy
      course_material = CourseMaterial.find(params[:id])
      if current_organization.imported_course_materials.delete(course_material)
        render json: { message: 'Course unimported successfully' }, status: :ok
      else
        render json: { error: 'Error removing imported course' }, status: :unprocessable_entity
      end
    end
  end
end

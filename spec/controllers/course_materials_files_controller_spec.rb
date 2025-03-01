require 'rails_helper'

describe CourseMaterialsFilesController do

  describe 'GET #show' do

    it 'assigns the requested instance course materials file' do
      @course_material_file = FactoryBot.create(:course_material_file)
      @course_material = @course_material_file.course_material
      get :show, params: { course_material_id: @course_material.id, id: @course_material_file.id }
      expect(response).to have_http_status(:success)
    end

  end

  describe 'GET #index' do

    it 'returns a success' do
      course_material = FactoryBot.create(:course_material, :with_file_archive)
      get :index, params: { course_material_id: course_material.id }
      expect(response).to have_http_status(:success)
    end

  end

end

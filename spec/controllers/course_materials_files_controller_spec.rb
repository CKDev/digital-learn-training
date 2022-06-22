require "rails_helper"

describe CourseMaterialsFilesController do

  describe "GET #show" do

    it "responds with success and assigns file" do
      @course_material_file = FactoryBot.create(:course_material_file)
      @course_material = @course_material_file.course_material
      get :show, params: { course_material_id: @course_material.id, id: @course_material_file.id }
      expect(response).to have_http_status(:success)
      expect(assigns(:file)).to eq(@course_material_file)
    end

  end

  describe "GET #index" do

    it "responds with success and assigns files" do
      @course_material_file1 = FactoryBot.create(:course_material_file)
      @course_material = @course_material_file1.course_material
      @course_material_file2 = FactoryBot.create(:course_material_file, course_material: @course_material)
      get :index, params: { course_material_id: @course_material.id }
      expect(response).to have_http_status(:success)
      expect(assigns(:files)).to include(@course_material_file1, @course_material_file2)
    end

  end

end

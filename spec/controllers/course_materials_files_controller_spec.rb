require "rails_helper"

describe CourseMaterialsFilesController do

  describe "GET #show" do

    it "assigns the requested instance course materials file" do
      @course_material_file = FactoryGirl.create(:course_material_file)
      @course_material = @course_material_file.course_material
      get :show, params: { course_material_id: @course_material.id, id: @course_material_file.id }
      expect(response).to have_http_status(:success)
    end

  end

  describe "GET #index" do

    it "assigns all the requested instances of a course materials files" do
      @course_material_file1 = FactoryGirl.create(:course_material_file)
      @course_material = @course_material_file1.course_material
      @course_material_file2 = FactoryGirl.create(:course_material_file, course_material: @course_material, file_file_name: "test_upload_2.pdf")
      get :index, params: { course_material_id: @course_material.id }
      expect(response).to have_http_status(:success)
    end

  end

end

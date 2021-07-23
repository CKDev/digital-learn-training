require "rails_helper"

describe CourseMaterialsMediasController do

  describe "GET #show" do

    it "assigns the requested instance course materials media" do
      @course_material_media = FactoryBot.create(:course_material_media)
      @course_material = @course_material_media.course_material
      get :show, params: { course_material_id: @course_material.id, id: @course_material_media.id }
      expect(response).to have_http_status(:success)
    end

  end

  describe "GET #index" do

    it "assigns all the requested instances of a course materials medias" do
      @course_material_media1 = FactoryBot.create(:course_material_media)
      @course_material = @course_material_media1.course_material
      @course_material_media2 = FactoryBot.create(:course_material_media, course_material: @course_material, media_file_name: "test2.png")
      get :index, params: { course_material_id: @course_material.id }
      expect(response).to have_http_status(:success)
    end

  end

end

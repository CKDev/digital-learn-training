require "rails_helper"

describe Admin::CourseMaterialsController do

  describe "GET #new" do

    it "assigns a new instance of a course_material" do
      @admin = FactoryBot.create(:admin)
      sign_in @admin
      get :new
      expect(assigns(:course_material)).to be_an_instance_of(CourseMaterial)
    end

    it "redirects to the homepage if not authenticated" do
      get :new
      expect(response).to redirect_to new_user_session_path
    end

  end

  describe "GET #index" do

    it "assigns all course_materials" do
      @admin = FactoryBot.create(:admin)
      sign_in @admin
      @course_material1 = FactoryBot.create(:course_material)
      @course_material2 = FactoryBot.create(:course_material)
      @course_material3 = FactoryBot.create(:course_material, pub_status: "A")
      get :index
      expect(assigns(:course_materials)).to contain_exactly(@course_material1, @course_material2)
    end

    it "redirects to the homepage if not authenticated" do
      get :index
      expect(response).to redirect_to new_user_session_path
    end

  end

  describe "POST #create" do

    before :each do
      @category = FactoryBot.create(:category)
    end

    let(:file_upload) do
      fixture_file_upload(Rails.root.join("spec", "fixtures", "test_upload.pdf"), "application/pdf")
    end

    let(:media_upload) do
      fixture_file_upload(Rails.root.join("spec", "fixtures", "test.png"), "image/png")
    end

    let(:valid_attributes) do
      {
        title: "New Course Material",
        contributor: "Alejandro",
        summary: "Summary of Course Material",
        description: "Description of Course Material",
        category_id: @category.id,
        pub_status: "P",
        course_material_files_attributes: {
          "0" => {
            file: file_upload
          }
        },
        course_material_medias_attributes: {
          "0" => {
            media: media_upload
          }
        },
        course_material_videos_attributes: {
          "0" => {
            url: "https://youtu.be/xXXtEK_QdNQ"
          }
        }
      }
    end

    let(:invalid_attributes) do
      {
        title: "",
        contributor: "",
        summary: "",
        description: "",
        category_id: "",
        pub_status: ""
      }
    end

    it "correctly assigns the passed in info" do
      @admin = FactoryBot.create(:admin)
      sign_in @admin
      post :create, params: { course_material: valid_attributes }
      course_material = CourseMaterial.last
      expect(course_material.title).to eq "New Course Material"
      expect(course_material.contributor).to eq "Alejandro"
      expect(course_material.summary).to eq "Summary of Course Material"
      expect(course_material.description).to eq "Description of Course Material"
      expect(course_material.pub_status).to eq "P"
      expect(course_material.course_material_files.first.present?).to be true
      expect(course_material.course_material_medias.first.present?).to be true
      expect(course_material.course_material_videos.first.present?).to be true
    end

    it "renders the new view if there is missing information" do
      @admin = FactoryBot.create(:admin)
      sign_in @admin
      post :create, params: { course_material: invalid_attributes }
      expect(response).to render_template :new
    end

    it "redirects to the homepage if not authenticated" do
      post :create, params: { course_material: valid_attributes }
      expect(response).to redirect_to new_user_session_path
    end

  end

  describe "GET #edit" do

    it "assigns the given instance of a course_material" do
      @admin = FactoryBot.create(:admin)
      sign_in @admin
      @course_material = FactoryBot.create(:course_material)
      get :edit, params: { id: @course_material.id }
      expect(assigns(:course_material)).to eq @course_material
    end

    it "redirects to the homepage if not authenticated" do
      get :edit, params: { id: 1 }
      expect(response).to redirect_to new_user_session_path
    end

  end

  describe "PUT #update" do

    before :each do
      @category = FactoryBot.create(:category)
    end

    let(:valid_attributes) do
      {
        title: "Updated Course Material",
        contributor: "Alejandro Brinkster",
        summary: "Summary of Updated Course Material",
        description: "Description of Updated Course Material",
        pub_status: "P",
        category_id: @category.id
      }
    end

    let(:invalid_attributes) do
      {
        title: "",
        contributor: "",
        summary: "",
        description: "",
        pub_status: "",
        category_id: ""
      }
    end

    it "correctly assigns the passed in info" do
      @course_material = FactoryBot.create(:course_material)
      @admin = FactoryBot.create(:admin)
      sign_in @admin
      put :update, params: { id: @course_material.id, course_material: valid_attributes }
      @course_material.reload
      expect(@course_material.title).to eq "Updated Course Material"
      expect(@course_material.contributor).to eq "Alejandro Brinkster"
      expect(@course_material.summary).to eq "Summary of Updated Course Material"
      expect(@course_material.description).to eq "Description of Updated Course Material"
      expect(@course_material.pub_status).to eq "P"
    end

    it "removes the subcategory id if not passed in" do
      @admin = FactoryBot.create(:admin)
      sign_in @admin
      @course_material = FactoryBot.create(:course_material)
      @course_material.update(sub_category_id: 2)
      put :update, params: { id: @course_material.id, course_material: valid_attributes }
      @course_material.reload
      expect(@course_material.sub_category_id.blank?).to be true
    end

    it "renders the edit view if there is missing information" do
      @course_material = FactoryBot.create(:course_material)
      @admin = FactoryBot.create(:admin)
      sign_in @admin
      put :update, params: { id: @course_material.id, course_material: invalid_attributes }
      expect(response).to render_template :edit
    end

    it "redirects to the homepage if not authenticated" do
      put :update, params: { id: 1, course_material: valid_attributes }
      expect(response).to redirect_to new_user_session_path
    end

  end

  describe "PUT #sort" do

    before :each do
      @course_material1 = FactoryBot.create(:course_material)
      @course_material2 = FactoryBot.create(:course_material)
      @course_material3 = FactoryBot.create(:course_material)
    end

    it "should update to the given sort order" do
      @admin = FactoryBot.create(:admin)
      sign_in @admin

      order = {
        "0": { "id": @course_material3.id, "position": "1" },
        "1": { "id": @course_material1.id, "position": "2" },
        "2": { "id": @course_material2.id, "position": "3" }
      }
      put :sort, params: { order: order }, format: :json

      [@course_material1, @course_material2, @course_material3].each(&:reload)
      expect(@course_material1.sort_order).to eq 2
      expect(@course_material2.sort_order).to eq 3
      expect(@course_material3.sort_order).to eq 1
    end

  end

end

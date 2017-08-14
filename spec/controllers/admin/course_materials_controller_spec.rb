require "rails_helper"

describe Admin::CourseMaterialsController do

  describe "GET #new" do

    it "assigns a new instance of a course_material" do
      @admin = FactoryGirl.create(:admin)
      sign_in @admin
      get :new
      expect(assigns(:course_material)).to be_an_instance_of(CourseMaterial)
    end

  end

  describe "GET #index" do

    it "assigns all course_materials" do
      @admin = FactoryGirl.create(:admin)
      sign_in @admin
      @course_material1 = FactoryGirl.create(:course_material)
      @course_material2 = FactoryGirl.create(:course_material)
      get :index
      expect(assigns(:course_materials)).to contain_exactly(@course_material1, @course_material2)
    end

    pending "permissions"

  end

  describe "POST #create" do

    let(:valid_attributes) do
      {
        title: "New Course Material",
        contributor: "Alejandro",
        summary: "Summary of Course Material",
        description: "Description of Course Material"
      }
    end

    let(:invalid_attributes) do
      {
        title: "",
        contributor: "",
        summary: "",
        description: ""
      }
    end

    it "correctly assigns the passed in info" do
      @admin = FactoryGirl.create(:admin)
      sign_in @admin
      post :create, params: { course_material: valid_attributes }
      course_material = CourseMaterial.last
      expect(course_material.title).to eq "New Course Material"
      expect(course_material.contributor).to eq "Alejandro"
      expect(course_material.summary).to eq "Summary of Course Material"
      expect(course_material.description).to eq "Description of Course Material"
    end

    it "renders the new view if there is missing information" do
      @admin = FactoryGirl.create(:admin)
      sign_in @admin
      post :create, params: { course_material: invalid_attributes }
      expect(response).to render_template :new
    end

  end

  describe "GET #edit" do

    it "assigns the given instance of a course_material" do
      @admin = FactoryGirl.create(:admin)
      sign_in @admin
      @course_material = FactoryGirl.create(:course_material)
      get :edit, params: { id: @course_material.id }
      expect(assigns(:course_material)).to eq @course_material
    end

  end

  describe "PUT #update" do

    let(:valid_attributes) do
      {
        title: "Updated Course Material",
        contributor: "Alejandro Brinkster",
        summary: "Summary of Updated Course Material",
        description: "Description of Updated Course Material"
      }
    end

    let(:invalid_attributes) do
      {
        title: "",
        contributor: "",
        summary: "",
        description: ""
      }
    end

    it "correctly assigns the passed in info" do
      @course_material = FactoryGirl.create(:course_material)
      @admin = FactoryGirl.create(:admin)
      sign_in @admin
      put :update, params: { id: @course_material.id, course_material: valid_attributes }
      @course_material.reload
      expect(@course_material.title).to eq "Updated Course Material"
      expect(@course_material.contributor).to eq "Alejandro Brinkster"
      expect(@course_material.summary).to eq "Summary of Updated Course Material"
      expect(@course_material.description).to eq "Description of Updated Course Material"
    end

    it "renders the edit view if there is missing information" do
      @course_material = FactoryGirl.create(:course_material)
      @admin = FactoryGirl.create(:admin)
      sign_in @admin
      put :update, params: { id: @course_material.id, course_material: invalid_attributes }
      expect(response).to render_template :edit
    end

  end

end

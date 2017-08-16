require "rails_helper"

describe Admin::CoursesController do

  describe "GET #new" do

    it "assigns a new instance of a course" do
      @admin = FactoryGirl.create(:admin)
      sign_in @admin
      get :new
      expect(assigns(:course)).to be_an_instance_of(Course)
    end

  end

  describe "GET #index" do

    it "assigns all courses that aren't archived" do
      @admin = FactoryGirl.create(:admin)
      sign_in @admin
      @course1 = FactoryGirl.create(:course)
      @course2 = FactoryGirl.create(:course)
      @course3 = FactoryGirl.create(:course, pub_status: "A")
      get :index
      expect(assigns(:courses)).to contain_exactly(@course1, @course2)
    end

    pending "permissions"

  end

  describe "POST #create" do

    let(:valid_attributes) do
      {
        title: "Title",
        summary: "Summary",
        description: "Description",
        notes: "Notes",
        contributor: "Contributor",
        pub_status: "P",
        seo_page_title: "SEO Course Title",
        meta_desc: "Meta Desc"
      }
    end

    let(:invalid_attributes) do
      {
        title: "",
        summary: "",
        description: "",
        notes: "",
        contributor: "",
        pub_status: ""
      }
    end

    it "correctly assigns the passed in info" do
      @admin = FactoryGirl.create(:admin)
      sign_in @admin
      post :create, params: { course: valid_attributes }
      course = Course.last
      expect(course.title).to eq "Title"
      expect(course.summary).to eq "Summary"
      expect(course.description).to eq "Description"
      expect(course.notes).to eq "Notes"
      expect(course.contributor).to eq "Contributor"
      expect(course.seo_page_title).to eq "SEO Course Title"
      expect(course.meta_desc).to eq "Meta Desc"
    end

    it "renders the new view if there is missing information" do
      @admin = FactoryGirl.create(:admin)
      sign_in @admin
      post :create, params: { course: invalid_attributes }
      expect(response).to render_template :new
    end

  end

  describe "GET #edit" do

    it "assigns the given instance of a course" do
      @admin = FactoryGirl.create(:admin)
      sign_in @admin
      @course = FactoryGirl.create(:course)
      get :edit, params: { id: @course.id }
      expect(assigns(:course)).to eq @course
    end

  end

  describe "PUT #update" do

    let(:valid_attributes) do
      {
        title: "Updated Title",
        summary: "Updated Summary",
        description: "Updated Description",
        notes: "Updated Notes",
        contributor: "Updated Contributor",
        pub_status: "A",
        seo_page_title: "Updated SEO Course Title",
        meta_desc: "Updated Meta Desc"
      }
    end

    let(:invalid_attributes) do
      {
        title: "",
        summary: "",
        description: "",
        notes: "",
        contributor: "",
        pub_status: ""
      }
    end

    it "correctly assigns the passed in info" do
      @course = FactoryGirl.create(:course)
      @admin = FactoryGirl.create(:admin)
      sign_in @admin
      put :update, params: { id: @course.id, course: valid_attributes }
      @course.reload
      expect(@course.title).to eq "Updated Title"
      expect(@course.summary).to eq "Updated Summary"
      expect(@course.description).to eq "Updated Description"
      expect(@course.notes).to eq "Updated Notes"
      expect(@course.contributor).to eq "Updated Contributor"
      expect(@course.seo_page_title).to eq "Updated SEO Course Title"
      expect(@course.meta_desc).to eq "Updated Meta Desc"
    end

    it "renders the edit view if there is missing information" do
      @course = FactoryGirl.create(:course)
      @admin = FactoryGirl.create(:admin)
      sign_in @admin
      put :update, params: { id: @course.id, course: invalid_attributes }
      expect(response).to render_template :edit
    end

  end

end

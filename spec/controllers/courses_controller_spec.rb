require "rails_helper"

describe CoursesController do

  describe "GET #show" do

    it "assigns the requested instance of a course" do
      @course = FactoryBot.create(:course, :with_lessons)
      get :show, params: { id: @course.slug }
      expect(assigns(:course)).to eq @course
    end

    it "redirects to the root path if the course is in draft status" do
      @course = FactoryBot.create(:course, :with_lessons, pub_status: "D")
      get :show, params: { id: @course.slug }
      expect(response).to redirect_to root_path
    end

    it "redirects to the root path if the course is in archived status" do
      @course = FactoryBot.create(:course, :with_lessons, pub_status: "A")
      get :show, params: { id: @course.slug }
      expect(response).to redirect_to root_path
    end

  end

  describe "GET #index" do

    it "assigns all published courses" do
      @course1 = FactoryBot.create(:course, :with_lessons)
      @course2 = FactoryBot.create(:course, :with_lessons, pub_status: "D")
      @course3 = FactoryBot.create(:course, :with_lessons)
      get :index
      expect(assigns(:courses)).to contain_exactly(@course1, @course3)
    end

  end

  describe "POST #start" do

    it "redirects to the first lesson page" do
      @course = FactoryBot.create(:course, :with_lessons)
      post :start, params: { course_id: @course.id }
      expect(response).to redirect_to course_lesson_path(@course, @course.lessons.first.id)
    end

  end

  describe "GET #complete" do

    it "renders the completed course page" do
      @course = FactoryBot.create(:course, :with_lessons)
      get :complete, params: { course_id: @course.id }
      expect(assigns(:course)).to eq @course
    end

    it "returns the generated pdf" do
      @course = FactoryBot.create(:course, :with_lessons)
      get :complete, params: { course_id: @course.id, format: :pdf }
      expect(assigns(:pdf).present?).to be true
    end

  end

  describe "GET #view_attachment" do

    it "renders the attachment" do
      @attachment = FactoryBot.create(:attachment)
      @course = @attachment.course
      get :view_attachment, params: { course_id: @course.id, attachment_id: @attachment.id }
      expect(assigns(:course)).to eq @course
    end

  end

end

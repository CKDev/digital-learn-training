require "rails_helper"

describe CoursesController do

  describe "GET #show" do

    it "assigns the requested instance of a course" do
      @course = FactoryGirl.create(:course_with_lessons)
      get :show, params: { id: @course.slug }
      expect(assigns(:course)).to eq @course
    end

    it "redirects to the root path if the course is in draft status" do
      @course = FactoryGirl.create(:course_with_lessons, pub_status: "D")
      get :show, params: { id: @course.slug }
      expect(response).to redirect_to root_path
    end

    it "redirects to the root path if the course is in archived status" do
      @course = FactoryGirl.create(:course_with_lessons, pub_status: "A")
      get :show, params: { id: @course.slug }
      expect(response).to redirect_to root_path
    end

  end

  describe "GET #index" do

    it "assigns all published courses" do
      @course1 = FactoryGirl.create(:course_with_lessons)
      @course2 = FactoryGirl.create(:course_with_lessons, pub_status: "D")
      @course3 = FactoryGirl.create(:course_with_lessons)
      get :index
      expect(assigns(:courses)).to contain_exactly(@course1, @course3)
    end

  end

end

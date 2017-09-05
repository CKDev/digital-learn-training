require "rails_helper"

describe LessonsController do

  describe "GET #show" do

    it "assigns the requested instance of a lesson" do
      @course = FactoryGirl.create(:course_with_lessons)
      get :show, params: { course_id: @course.slug, id: @course.lessons.first.slug }
      expect(assigns(:lesson)).to eq @course.lessons.first
    end

  end

end

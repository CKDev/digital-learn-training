require 'rails_helper'

describe LessonsController do

  describe 'GET #index' do

    it 'assigns published lessons' do
      @course = create(:course, :with_lessons)
      @course.lessons.second.update(pub_status: 'D')
      get :index, params: { course_id: @course.slug }
      expect(assigns(:lessons).first).to eq @course.lessons.first
      expect(assigns(:lessons).second).to eq @course.lessons.third
    end

  end

  describe 'GET #show' do

    it 'assigns the requested instance of a lesson' do
      @course = create(:course, :with_lessons)
      get :show, params: { course_id: @course.slug, id: @course.lessons.first.slug }
      expect(assigns(:lesson)).to eq @course.lessons.first
    end

    it 'redirects for a draft lesson' do
      @course = create(:course, :with_lessons)
      @course.lessons.first.update(pub_status: 'D')
      get :show, params: { course_id: @course.slug, id: @course.lessons.first.slug }
      expect(response).to redirect_to course_path(@course)
    end

    it 'redirects for an archived lesson' do
      @course = create(:course, :with_lessons)
      @course.lessons.first.update(pub_status: 'A')
      get :show, params: { course_id: @course.slug, id: @course.lessons.first.slug }
      expect(response).to redirect_to root_path
    end

  end

  describe 'GET #lesson_complete' do

    it 'redirects to the next lesson' do
      @course = create(:course, :with_lessons)
      get :lesson_complete, params: { course_id: @course.slug, lesson_id: @course.lessons.first.id }
      expect(assigns(:current_lesson)).to eq @course.lessons.first
      expect(assigns(:next_lesson)).to eq @course.lessons.second
    end

  end

  describe 'POST #complete' do

    it 'redirects to the next lesson' do
      @course = create(:course, :with_lessons)
      post :complete, params: { course_id: @course.slug, lesson_id: @course.lessons.first.id }
      expect(response).to redirect_to course_lesson_path(@course, @course.lessons.second.id)
    end

    it 'redirects to course complete page if the lesson is the assessment' do
      @course = create(:course, :with_lessons)
      @course.lessons.third.update(is_assessment: true)
      post :complete, params: { course_id: @course.slug, lesson_id: @course.lessons.third.id }
      expect(response).to redirect_to redirect_to course_complete_path(@course)
    end

  end

end

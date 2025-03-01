require 'rails_helper'

describe Admin::CoursesController do
  let(:admin) { create(:admin) }

  describe 'GET #new' do
    it 'assigns a new instance of a course' do
      sign_in admin
      get :new
      expect(assigns(:course)).to be_an_instance_of(Course)
    end

    it 'redirects to the homepage if not authenticated' do
      get :new
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe 'GET #index' do
    it "assigns all courses that aren't archived" do
      sign_in admin
      course1 = create(:course)
      course2 = create(:course)
      create(:course, pub_status: 'A')

      get :index
      expect(assigns(:courses)).to contain_exactly(course1, course2)
    end

    it 'redirects to the homepage if not authenticated' do
      get :index
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe 'POST #create' do
    let(:valid_attributes) do
      {
        title: 'Title',
        summary: 'Summary',
        description: 'Description',
        notes: 'Notes',
        contributor: 'Contributor',
        pub_status: 'P',
        seo_page_title: 'SEO Course Title',
        meta_desc: 'Meta Desc'
      }
    end

    let(:invalid_attributes) do
      {
        title: '',
        summary: '',
        description: '',
        notes: '',
        contributor: '',
        pub_status: ''
      }
    end

    it 'redirects to the homepage if not authenticated' do
      post :create, params: { course: valid_attributes }
      expect(response).to redirect_to new_user_session_path
    end

    context 'when authenticated as admin' do
      before { sign_in admin }

      it 'correctly assigns the passed in info' do
        post :create, params: { course: valid_attributes }
        course = Course.last
        expect(course.title).to eq 'Title'
        expect(course.summary).to eq 'Summary'
        expect(course.description).to eq 'Description'
        expect(course.notes).to eq 'Notes'
        expect(course.contributor).to eq 'Contributor'
        expect(course.seo_page_title).to eq 'SEO Course Title'
        expect(course.meta_desc).to eq 'Meta Desc'
      end

      it 'redirects to the course path if the Save Course button was clicked' do
        post :create, params: { course: valid_attributes, commit: 'Save Course' }
        course = Course.last
        expect(response).to redirect_to edit_admin_course_path(course)
      end

      it 'renders the new view if there is missing information' do
        post :create, params: { course: invalid_attributes }
        expect(response).to render_template :new
      end
    end
  end

  describe 'GET #edit' do
    it 'assigns the given instance of a course' do
      sign_in admin
      course = create(:course)
      get :edit, params: { id: course.id }
      expect(assigns(:course)).to eq course
    end

    it 'redirects to the homepage if not authenticated' do
      get :edit, params: { id: 1 }
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe 'PUT #update' do
    let(:valid_attributes) do
      {
        title: 'Updated Title',
        summary: 'Updated Summary',
        description: 'Updated Description',
        notes: 'Updated Notes',
        contributor: 'Updated Contributor',
        pub_status: 'A',
        seo_page_title: 'Updated SEO Course Title',
        meta_desc: 'Updated Meta Desc'
      }
    end

    let(:invalid_attributes) do
      {
        title: '',
        summary: '',
        description: '',
        notes: '',
        contributor: '',
        pub_status: ''
      }
    end

    it 'redirects to the homepage if not authenticated' do
      put :update, params: { id: 1, course: valid_attributes }
      expect(response).to redirect_to new_user_session_path
    end

    context 'when authenticated as an admin' do
      let(:course) { create(:course) }

      before { sign_in admin }

      it 'correctly assigns the passed in info' do
        put :update, params: { id: course.id, course: valid_attributes }
        course.reload
        expect(course.title).to eq 'Updated Title'
        expect(course.summary).to eq 'Updated Summary'
        expect(course.description).to eq 'Updated Description'
        expect(course.notes).to eq 'Updated Notes'
        expect(course.contributor).to eq 'Updated Contributor'
        expect(course.seo_page_title).to eq 'Updated SEO Course Title'
        expect(course.meta_desc).to eq 'Updated Meta Desc'
      end

      it 'redirects to the course path if the Save Course button was clicked' do
        put :update, params: { id: course.id, course: valid_attributes, commit: 'Save Course' }
        course.reload
        expect(response).to redirect_to edit_admin_course_path(course)
      end

      it 'redirects to the course path if the Save Course and Edit Lessons button was clicked' do
        create(:lesson, course: course)
        put :update, params: { id: course.id, course: valid_attributes, commit: 'Save Course and Edit Lessons' }
        course.reload
        expect(response).to redirect_to edit_admin_course_lesson_path(course, course.lessons.first)
      end

      it 'renders the edit view if there is missing information' do
        put :update, params: { id: course.id, course: invalid_attributes }
        expect(response).to render_template :edit
      end
    end
  end

  describe 'PUT #sort' do
    let(:beginner) { create(:course) }
    let(:intermediate) { create(:course) }
    let(:advanced) { create(:course) }

    before { sign_in admin }

    it 'updates to the given sort order' do
      order = {
        '0': { id: advanced.id, position: '1' },
        '1': { id: beginner.id, position: '2' },
        '2': { id: intermediate.id, position: '3' }
      }
      put :sort, params: { order: order }, format: :json

      [beginner, intermediate, advanced].each(&:reload)
      expect(beginner.course_order).to eq 2
      expect(intermediate.course_order).to eq 3
      expect(advanced.course_order).to eq 1
    end
  end
end

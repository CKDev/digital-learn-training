require 'rails_helper'

describe Admin::CoursesArchiveController do

  describe 'GET #index' do

    it 'assigns all courses' do
      @admin = create(:admin)
      sign_in @admin
      @course1 = create(:course)
      @course2 = create(:course, pub_status: 'A')
      @course3 = create(:course, pub_status: 'A')
      get :index
      expect(assigns(:courses)).to contain_exactly(@course2, @course3)
    end

    it 'redirects to the homecourse if not authenticated' do
      get :index
      expect(response).to redirect_to new_user_session_path
    end

  end

end

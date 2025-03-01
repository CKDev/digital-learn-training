require 'rails_helper'

describe Admin::CourseMaterialsArchiveController do

  describe 'GET #index' do

    it 'assigns all courses' do
      @admin = create(:admin)
      sign_in @admin
      @course_materials1 = create(:course_material)
      @course_materials2 = create(:course_material, pub_status: 'A')
      @course_materials3 = create(:course_material, pub_status: 'A')
      get :index
      expect(assigns(:course_materials)).to contain_exactly(@course_materials2, @course_materials3)
    end

    it 'redirects to the homecourse if not authenticated' do
      get :index
      expect(response).to redirect_to new_user_session_path
    end

  end

end

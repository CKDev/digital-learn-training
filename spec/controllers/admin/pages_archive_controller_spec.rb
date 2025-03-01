require 'rails_helper'

describe Admin::PagesArchiveController do

  describe 'GET #index' do

    it 'assigns all pages' do
      @admin = create(:admin)
      sign_in @admin
      @page1 = create(:page)
      @page2 = create(:page, pub_status: 'A')
      @page3 = create(:page, pub_status: 'A')
      get :index
      expect(assigns(:pages)).to contain_exactly(@page2, @page3)
    end

    it 'redirects to the homecourse if not authenticated' do
      get :index
      expect(response).to redirect_to new_user_session_path
    end

  end

end

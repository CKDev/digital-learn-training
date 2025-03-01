require 'rails_helper'

describe Admin::AttachmentsController do

  describe '#destroy' do

    it 'removes the attachment' do
      @admin = create(:admin)
      sign_in @admin

      @attachment = create(:attachment)
      expect do
        delete :destroy, params: { id: @attachment.id }
      end.to change(Attachment, :count).by(-1)
    end

    it 'redirects to the homepage if not authenticated' do
      delete :destroy, params: { id: 1 }
      expect(response).to redirect_to new_user_session_path
    end

  end

end

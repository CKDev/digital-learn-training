require "rails_helper"

describe Admin::AttachmentsController do

  context "#destroy" do

    it "should remove the attachment" do
      @admin = FactoryBot.create(:admin)
      sign_in @admin

      @attachment = FactoryBot.create(:attachment)
      expect do
        delete :destroy, params: { id: @attachment.id }
      end.to change { Attachment.count }.by(-1)
    end

    it "redirects to the homepage if not authenticated" do
      delete :destroy, params: { id: 1 }
      expect(response).to redirect_to new_user_session_path
    end

  end

end

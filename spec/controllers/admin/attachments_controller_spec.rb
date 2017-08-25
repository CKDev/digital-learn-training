require "rails_helper"

describe Admin::AttachmentsController do

  context "#destroy" do

    it "should remove the attachment" do
      @admin = FactoryGirl.create(:admin)
      sign_in @admin

      @attachment = FactoryGirl.create(:attachment)
      expect do
        delete :destroy, params: { id: @attachment.id }
      end.to change { Attachment.count }.by(-1)
    end

  end

end

module Admin
  class AttachmentsController < BaseController

    def destroy
      @attachment = Attachment.find(params[:id])
      @attachment.destroy
      redirect_back fallback_location: admin_root_path
    end

  end
end

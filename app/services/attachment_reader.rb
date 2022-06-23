class AttachmentReader
  def initialize(file)
    @file = file
  end

  def read_attachment_data(attachment_name)
    if Rails.application.config.s3_enabled
      @file.send(attachment_name).download
    else
      attachment_path = ActiveStorage::Blob.service.path_for(@file.send(attachment_name).key)
      open(attachment_path).read
    end
  end
end

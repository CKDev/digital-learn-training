class AttachmentReader
  def initialize(file)
    @file = file
  end

  def read_attachment_data
    if Rails.application.config.s3_enabled
      s3 = Aws::S3::Client.new
      response = s3.get_object({
        bucket: Rails.application.config.s3_bucket_name,
        key: file.path
      })
      response.body.read
    else
      File.read(file.path)
    end
  end
end

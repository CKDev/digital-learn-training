class S3Uploader
  def initialize(bucket)
    @bucket = bucket
  end

  def copy_to_s3!(record, style: nil, attachment_name:)
    filename = record.send("#{attachment_name}_file_name")
    s3_path = "#{record.class.name.downcase.pluralize}/#{attachment_name.pluralize}/#{record.id}"
    s3_path += "/#{style}" if style.present? 
    s3_path += "/#{filename}"

    file = File.open(record.send(attachment_name).path(style))

    puts "Uploading #{filename}..."
    @bucket.objects[s3_path].write(file, acl: :public_read)
  end
end
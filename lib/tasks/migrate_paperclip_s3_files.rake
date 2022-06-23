namespace :migrate_paperclip do
  desc 'Re-upload attachments with ActiveStorage to new S3 locations'
  task migrate_paperclip_s3_files: :environment do
    bucket = Rails.application.config.s3_bucket_name
    region = Rails.application.config.s3_region
    base_s3_url = "https://#{bucket}.s3.#{region}.amazonaws.com"

    Attachment.find_each do |attachment|
      filename = attachment.document_file_name
      content_type = attachment.document_content_type
      s3_url = "#{base_s3_url}/attachments/documents/#{attachment.id}/#{filename}"
    
      puts "Re-uploading Attachment #{attachment.id} to ActiveStorage\n"
      
      begin
        attachment.document.attach(
          io: open(s3_url),
          filename: filename,
          content_type: content_type
        )
      rescue => e
        puts "Error re-uploading Attachment #{attachment.id}: #{e}"
      end
    end

    CourseMaterialFile.find_each do |cmf|
      filename = cmf.file_file_name
      content_type = cmf.file_content_type
      s3_url = "#{base_s3_url}/coursematerialfiles/files/#{cmf.id}/#{filename}"
    
      puts "Re-uploading CourseMaterialFile #{cmf.id} to ActiveStorage\n"
      
      begin
        cmf.file.attach(
          io: open(s3_url),
          filename: filename,
          content_type: content_type
        )
      rescue => e
        puts "Error re-uploading CourseMaterialFile #{cmf.id}: #{e}"
      end
    end

    CourseMaterialMedia.find_each do |cmm|
      filename = cmm.media_file_name
      content_type = cmm.media_content_type

      puts "Re-uploading CourseMaterialMedia #{cmm.id} to ActiveStorage\n"

      ['original', 'thumb'].each do |style|
        s3_url = "#{base_s3_url}/coursematerialmedia/media/#{cmm.id}/#{style}/#{filename}"
        
        begin
          cmm.media.attach(
            io: URI.open(s3_url),
            filename: filename,
            content_type: content_type
          )
        rescue => e
          puts "Error re-uploading #{style} for CourseMaterialMedia #{cmm.id}: #{e}"
        end
      end
    end
  end
end

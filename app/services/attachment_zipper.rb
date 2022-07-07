class AttachmentZipper
  def initialize(files)
    @files = files
  end

  def create_zip(attachment_name)
    archive_tempfile = Tempfile.new("file_archive", "tmp")
  
    ::Zip::File.open(archive_tempfile.path, ::Zip::File::CREATE) do |zipfile|
      @files.each do |file|
        attachment = file.send(attachment_name)

        if Rails.application.config.s3_enabled
          blob = attachment.blob
          blob.open do |tempfile|
            zipfile.add(attachment.filename.to_s, tempfile.filename)
          end
        else
          file_path =  ActiveStorage::Blob.service.path_for(attachment.key)
          zipfile.add(attachment.filename.to_s, file_path)
        end
      end
    end

    open(archive_tempfile)
  end
end

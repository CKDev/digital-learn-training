class AttachmentZipper
  def initialize(files)
    @files = files
  end

  def create_zip(attachment_name)
    archive_tempfile = Tempfile.new("file_archive", "tmp")
  
    ::Zip::File.open(archive_tempfile.path, ::Zip::File::CREATE) do |zipfile|
      @files.each do |file|
        if Rails.application.config.s3_enabled
          s3_tempfile = Tempfile.new("s3_contents", "tmp")
          s3_tempfile << AttachmentReader.new(file).read_attachment_data(attachment_name)
          zipfile.add(file.send(attachment_name).filename, s3_tempfile.url)
        else
          file_path =  ActiveStorage::Blob.service.path_for(file.send(attachment_name).key)
          zipfile.add(file.send(attachment_name).filename, file_path)
        end
      end
    end

    open(archive_tempfile)
  end
end

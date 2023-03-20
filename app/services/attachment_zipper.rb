class AttachmentZipper
  def initialize(files)
    @files = files
  end

  def create_zip(attachment_name)
    archive_tempfile = Tempfile.new("file_archive", "tmp")

    # Avoid premature garbage collection by keeping tempfiles in array
    s3_tempfiles = []
    ::Zip::File.open(archive_tempfile.path, ::Zip::File::CREATE) do |zipfile|
      @files.each do |file|
        if Rails.application.config.s3_enabled
          s3_tempfile = Tempfile.new("s3_contents", "tmp")
          s3_tempfiles << s3_tempfile
          s3_tempfile << AttachmentReader.new(file).read_attachment_data(attachment_name)
          s3_tempfile.close
          zipfile.add(file.send("#{attachment_name}_file_name"), s3_tempfile.path)
        else
          zipfile.add(file.send("#{attachment_name}_file_name"), file.send(attachment_name).path)
        end
      end
    end

    s3_tempfiles = nil
    open(archive_tempfile)
  end
end

class AttachmentZipper
  def initialize(course_material, attachments)
    @course_title = course_material.title.parameterize(separator: '_')
    @attachments = attachments
  end

  def create_zip(attachment_type)
    archive_tempfile = Tempfile.new("#{@course_title}_archive", "tmp")

    ::Zip::File.open(archive_tempfile.path, ::Zip::File::CREATE) do |zipfile|
      @attachments.each do |attachment|
        filename = attachment.send("#{attachment_type}_file_name")
        file_data = AttachmentReader.new(attachment).read_attachment_data(attachment_type)

        zipfile.get_output_stream(filename) do |file|
          file.puts file_data
        end
      end
    end

    open(archive_tempfile)
  end
end

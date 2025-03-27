class AttachmentZipper
  def initialize(course_material_id, association_name, attachment_type)
    @course_material = CourseMaterial.find(course_material_id)
    @course_title = @course_material.title.parameterize(separator: '_')
    @attachments = @course_material.send(association_name.to_sym)
    @attachment_type = attachment_type
  end

  def create_zip
    @archive_tempfile = Tempfile.new(["#{@course_title}_archive", '.zip'])

    ::Zip::File.open(@archive_tempfile.path, ::Zip::File::CREATE) do |zipfile|
      @attachments.each do |attachment|
        filename = attachment.send("#{@attachment_type}_file_name")
        file_data = Paperclip.io_adapters.for(attachment.send(@attachment_type)).read

        # Ensure Windows compatiblel file names
        filename = filename.encode('CP850', invalid: :replace, undef: :replace)

        zipfile.get_output_stream(filename) do |file|
          file.write file_data
        end
      end
    end

    @course_material.update("#{@attachment_type}_archive" => @archive_tempfile)
    @archive_tempfile.close
    @archive_tempfile.unlink
  end
end

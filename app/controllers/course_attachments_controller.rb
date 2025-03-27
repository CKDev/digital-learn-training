class CourseAttachmentsController < ApplicationController
  def index
    @course_material = CourseMaterial.friendly.find(params[:course_material_id])
    combined_file = Tempfile.new(["#{@course_title}_archive", '.zip'])

    begin
      ::Zip::File.open(combined_file.path, ::Zip::File::CREATE) do |zipfile|
        add_files_to_zip(file_archive, zipfile) if @course_material.course_material_files.present?
        add_files_to_zip(media_archive, zipfile) if @course_material.course_material_medias.present?
      end

      file_options = {
        filename: "#{@course_material.title.parameterize(separator: '_')}_attachments_archive.zip",
        disposition: 'inline'
      }

      send_data File.binread(combined_file), file_options
    ensure
      combined_file.close
      combined_file.unlink
    end
  end

  private

  def file_archive
    AttachmentReader.new(@course_material.file_archive).read_attachment_data
  end

  def media_archive
    AttachmentReader.new(@course_material.media_archive).read_attachment_data
  end

  def add_files_to_zip(zip_content, zipfile)
    temp_file = Tempfile.new
    temp_file.binmode
    temp_file.write(zip_content)
    temp_file.rewind

    Zip::InputStream.open(temp_file.path) do |input_stream|
      while (entry = input_stream.get_next_entry)
        zipfile.get_output_stream(entry.name) do |f|
          f.write(input_stream.read)
        end
      end
    end

    temp_file.close
    temp_file.unlink
  end
end

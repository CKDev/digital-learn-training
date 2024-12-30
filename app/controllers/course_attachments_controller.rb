class CourseAttachmentsController < ApplicationController
  def index
    @course_material = CourseMaterial.friendly.find(params[:course_material_id])
    combined_file = Tempfile.new(["#{@course_title}_archive", ".zip"])

    begin
      ::Zip::File.open(combined_file.path, ::Zip::File::CREATE) do |zipfile|
        add_files_to_zip(file_archive, zipfile) if @course_material.course_material_files.present?
        add_files_to_zip(media_archive, zipfile) if @course_material.course_material_medias.present?
      end

      course_title = @course_material.title.parameterize(separator: "_")
      file_options = { filename: "#{course_title}_attachments_archive.zip", disposition: "inline", x_sendfile: true }

      send_file combined_file, file_options
      # ensure
      #   combined_file.close
      #   combined_file.unlink
    end
  end

  private

  def file_archive
    if Rails.application.config.s3_enabled
      URI.parse(@course_material.file_archive.url).open
    else
      File.open(@course_material.file_archive.path)
    end
  end

  def media_archive
    if Rails.application.config.s3_enabled
      URI.parse(@course_material.media_archive.url).open
    else
      File.open(@course_material.media_archive.path)
    end
  end

  def add_files_to_zip(zip_content, zipfile)
    if zip_content.is_a?(Tempfile) || zip_content.is_a?(File)
      zip_content = StringIO.new(zip_content.read)
    end

    Zip::InputStream.open(zip_content) do |input_stream|
      while (entry = input_stream.get_next_entry)
        zipfile.get_output_stream(entry.name) do |f|
          f.write(input_stream.read)
        end
      end
    end
  end
end

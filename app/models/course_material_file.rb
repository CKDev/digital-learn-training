class CourseMaterialFile < ApplicationRecord
  belongs_to :course_material
  has_attached_file :file, url: 'coursematerialfiles/files/:id/:basename.:extension'

  validates :file_file_name, uniqueness: { scope: :course_material, message: :unique_filename }

  validates_attachment_content_type :file,
                                    content_type: Constants.course_material_file_types, message: 'Only PDF, CSV, Word, PowerPoint, or Excel files are allowed.'

  after_commit :create_zip_archive

  def self.attachment_name
    'file'
  end

  def to_props
    { id: id,
      fileName: file_file_name,
      fileType: MimeTypeTranslator.readable_mime_type(file_content_type),
      downloadPath: Rails.application.routes.url_helpers.course_material_course_materials_file_path(course_material, id) }
  end

  private

  def create_zip_archive
    CourseMaterialArchiveJob.perform_later course_material.id, 'course_material_files', 'file'
  end
end

class CourseMaterialMedia < ApplicationRecord
  belongs_to :course_material
  has_attached_file :media, styles: { thumb: '112X75#' },
                            url: 'coursematerialmedia/media/:id/:style/:basename.:extension'

  validates :media_file_name, uniqueness: { scope: :course_material, message: :unique_filename }

  validates_attachment_content_type :media, content_type: Constants.course_material_media_types,
    message: 'Only PNG, JPG, GIF and WebP files are allowed.'

  after_commit :create_zip_archive

  def self.attachment_name
    'media'
  end

  def to_props
    # In dev, the media.url doesn't include a leading /, which is necessary for the image tags
    thumbnail_url = Rails.application.config.s3_enabled ? media.url(:thumb) : "/#{media.url(:thumb)}"

    { id: id,
      fileName: media_file_name,
      fileType: MimeTypeTranslator.readable_mime_type(media_content_type),
      thumbnailUrl: thumbnail_url,
      downloadPath: Rails.application.routes.url_helpers.course_material_course_materials_media_path(course_material, id) }
  end

  private

  def create_zip_archive
    CourseMaterialArchiveJob.perform_later course_material.id, 'course_material_medias', 'media'
  end
end

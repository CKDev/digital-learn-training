class CourseMaterialMedia < ApplicationRecord
  belongs_to :course_material
  has_attached_file :media, styles: { thumb: "212x140#" },
                            url: "coursematerialmedia/media/:id/:style/:basename.:extension"

  validates :media_file_name, uniqueness: { scope: :course_material, message: "should be unique for the course" }

  validates_attachment_content_type :media, content_type: Constants.course_material_media_types,
    message: "Only PNG, JPG and GIF files are allowed."

  after_commit :create_zip_archive

  def self.attachment_name
    "media"
  end

  private

  def create_zip_archive
    CourseMaterialArchiveJob.perform_later course_material.id, "course_material_medias", "media"
  end
end

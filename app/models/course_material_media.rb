class CourseMaterialMedia < ApplicationRecord
  belongs_to :course_material
  has_attached_file :media, styles: { thumb: "212x140#" }

  validates_attachment_content_type :media, content_type: Constants.course_material_media_types,
    message: "Only PNG, JPG, GIF, WEBP, or MP4 files are allowed."

end

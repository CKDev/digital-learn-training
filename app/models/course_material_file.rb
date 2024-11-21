class CourseMaterialFile < ApplicationRecord
  belongs_to :course_material
  has_attached_file :file, url: "coursematerialfiles/files/:id/:basename.:extension"

  validates :file_file_name, uniqueness: { scope: :course_material, message: "should be unique for the course" }

  validates_attachment_content_type :file,
                                    content_type: Constants.course_material_file_types, message: "Only PDF, CSV, Word, PowerPoint, or Excel files are allowed."

  after_commit :create_zip_archive

  def self.attachment_name
    "file"
  end

  private

  def create_zip_archive
    CourseMaterialArchiveJob.perform_later course_material.id, "course_material_files", "file"
  end
end

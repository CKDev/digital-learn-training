class Attachment < ApplicationRecord
  belongs_to :course
  has_attached_file :document

  # TODO: pull out this list into constants.
  validates_attachment_content_type :document,
    content_type: ["application/pdf", "text/plain", "application/vnd.ms-excel",
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", "application/vnd.ms-powerpoint",
      "application/vnd.openxmlformats-officedocument.presentationml.presentation",
      "application/msword", "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
      "application/octet-stream", "application/zip"],
    message: ", Only PDF, Word, PowerPoint, Excel, or Story files are allowed."

  validates :doc_type, allow_blank: true, inclusion: { in: %w(supplemental post-course), message: "%{value} is not a doc_type" }

  scope :supplemental_attachments, -> { where(doc_type: "supplemental") }
  scope :post_course_attachments, -> { where(doc_type: "post-course") }

end

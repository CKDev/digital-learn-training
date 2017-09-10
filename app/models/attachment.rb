class Attachment < ApplicationRecord
  belongs_to :course
  has_attached_file :document

  validates_attachment_content_type :document,
    content_type: Constants.attachment_content_types, message: "only PDF, Word, PowerPoint, Excel, or Story files are allowed."
  validates :doc_type, allow_blank: true, inclusion: { in: %w(supplemental post-course), message: "%{value} is not a doc_type" }

  scope :supplemental_attachments, -> { where(doc_type: "supplemental") }
  scope :post_course_attachments, -> { where(doc_type: "post-course") }

end

class Attachment < ApplicationRecord
  belongs_to :course
  has_attached_file :document, url: 'attachments/documents/:id/:basename.:extension'

  validates_attachment_content_type :document,
                                    content_type: Constants.attachment_content_types, message: 'only PDF, Word, PowerPoint, Excel, or Story files are allowed.'
  validates :doc_type, allow_blank: true, inclusion: { in: %w(supplemental post-course), message: '%<value>s is not a doc_type' }

  scope :supplemental_attachments, -> { where(doc_type: 'supplemental') }
  scope :post_course_attachments, -> { where(doc_type: 'post-course') }

  def to_props
    { id: id,
      fileName: document_file_name,
      fileType: MimeTypeTranslator.readable_mime_type(document_content_type),
      downloadPath: Rails.application.routes.url_helpers.course_attachment_path(course, id) }
  end
end

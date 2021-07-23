class Constants

  def self.acceptable_doc_types
    [
      "application/msword", "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
      "application/vnd.openxmlformats-officedocument.presentationml.presentation"
    ].join(", ")
  end

  def self.course_material_file_types
    [
      "application/pdf", "application/vnd.ms-excel", "text/csv",
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", "application/vnd.ms-powerpoint",
      "application/vnd.openxmlformats-officedocument.presentationml.presentation",
      "application/msword", "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
    ]
  end

  def self.course_material_file_types_str
    course_material_file_types.join(", ")
  end

  def self.attachment_content_types
    [
      "application/pdf", "application/vnd.ms-excel",
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", "application/vnd.ms-powerpoint",
      "application/vnd.openxmlformats-officedocument.presentationml.presentation",
      "application/msword", "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
      "application/octet-stream", "application/zip"
    ]
  end

  def self.attachment_content_types_str
    attachment_content_types.join(", ")
  end

  def self.course_material_media_types
    [
      "image/png", "image/jpeg", "image/gif"
    ]
  end

  def self.course_material_media_types_str
    course_material_media_types.join(", ")
  end

  def self.pub_status_select_options
    [["Draft", "D"], ["Published", "P"], ["Archived", "A"]]
  end
end

class MimeTypeTranslator
  def self.readable_mime_type(mime_type)
    case mime_type
    when "application/pdf"
      "PDF File"
    when "text/csv"
      "CSV File"
    when "application/vnd.ms-excel", "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      "Microsoft Excel"
    when "application/vnd.ms-powerpoint", "application/vnd.openxmlformats-officedocument.presentationml.presentation"
      "Microsoft PowerPoint"
    when "application/msword", "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
      "Microsoft Word"
    when "image/png"
      "PNG Image"
    when "image/jpeg"
      "JPEG Image"
    when "image/gif"
      "GIF Image"
    when "image/webp"
      "WebP Image"
    else
      ""
    end
  end
end

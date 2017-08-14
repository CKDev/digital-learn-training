class Constants

  def self.acceptable_doc_types
    types = [
      "application/msword", "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
      "application/vnd.openxmlformats-officedocument.presentationml.presentation"
    ]
    types.join(", ")
  end

end

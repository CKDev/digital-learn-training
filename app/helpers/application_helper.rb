module ApplicationHelper

  def svg_tag(filename, options = {})
    assets = Rails.application.assets
    file = assets.find_asset(filename).source.force_encoding("UTF-8")
    doc = Nokogiri::HTML::DocumentFragment.parse file
    svg = doc.at_css "svg"
    svg["class"] = options[:class] if options[:class].present?
    raw doc
  end

  def pub_status(status)
    case status
    when "D"
      "Draft"
    when "P"
      "Published"
    when "A"
      "Archived"
    end
  end

  def mime_type_conversion(mime_type)
    case mime_type
    when "application/pdf"
      "PDF File"
    when "text/csv"
      "CSV File"
    when "application/vnd.ms-excel"
      "Microsoft Excel"
    when "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      "Microsoft Excel"
    when "application/vnd.ms-powerpoint"
      "Microsoft PowerPoint"
    when "application/vnd.openxmlformats-officedocument.presentationml.presentation"
      "Microsoft PowerPoint"
    when "application/msword"
      "Microsoft Word"
    when "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
      "Microsoft Word"
    else
      ""
    end
  end

end

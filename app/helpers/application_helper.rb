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
    when "D" then "Draft"
    when "P" then "Published"
    when "A" then "Archived"
    end
  end

  def mime_type_conversion(mime_type)
    case mime_type
    when "application/pdf" then "PDF File"
    when "text/csv" then "CSV File"
    when "application/vnd.ms-excel" then "Microsoft Excel"
    when "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" then "Microsoft Excel"
    when "application/vnd.ms-powerpoint" then "Microsoft PowerPoint"
    when "application/vnd.openxmlformats-officedocument.presentationml.presentation" then "Microsoft PowerPoint"
    when "application/msword" then "Microsoft Word"
    when "application/vnd.openxmlformats-officedocument.wordprocessingml.document" then "Microsoft Word"
    else ""
    end
  end

  def add_active_base_link(base_paths, classes = "")
    if base_paths.is_a?(Array)
      base_paths.each do |path|
        path = "/#{path}" unless path.start_with? "/"
        return "#{classes} active".strip if request.path.start_with? path
      end
    else # Just passed in as a single path
      base_paths = "/#{base_path}" unless base_paths.start_with? "/"
      return "#{classes} active".strip if request.path.start_with? base_paths
    end
    classes
  end

  def contact_email
    current_organization&.contact_email || "support@digitallearn.org"
  end

end

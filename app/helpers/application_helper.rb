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

  def react_component(*args)
    content_tag :div, "", *args do
      render "shared/loading"
    end
  end

end

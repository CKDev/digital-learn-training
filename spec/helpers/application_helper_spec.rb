require "rails_helper"

describe ApplicationHelper do

  describe "#svg_tag" do

    it "returns the inline svg with given classes" do
      expected = <<~SVG
        <?xml version="1.0" standalone="no"?>
        <svg width="200" height="250" version="1.1" xmlns="http://www.w3.org/2000/svg" class="icon media-icon grey">
          <rect x="0" y="0" width="30" height="30"></rect>
        </svg>
      SVG
      expect(helper.svg_tag("icon-avatar.svg", class: "icon media-icon grey")).to eq expected
    end

  end

  describe "#pub_status" do

    it "returns the full name of the status" do
      expect(helper.pub_status("D")).to eq "Draft"
      expect(helper.pub_status("P")).to eq "Published"
      expect(helper.pub_status("A")).to eq "Archived"
    end

  end

  describe "#mime_type_conversion" do

    it "returns full name of the mime type" do
      expect(helper.mime_type_conversion("application/pdf")).to eq "PDF File"
      expect(helper.mime_type_conversion("text/csv")).to eq "CSV File"
      expect(helper.mime_type_conversion("application/vnd.ms-excel")).to eq "Microsoft Excel"
      expect(helper.mime_type_conversion("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")).to eq "Microsoft Excel"
      expect(helper.mime_type_conversion("application/vnd.ms-powerpoint")).to eq "Microsoft PowerPoint"
      expect(helper.mime_type_conversion("application/vnd.openxmlformats-officedocument.presentationml.presentation")).to eq "Microsoft PowerPoint"
      expect(helper.mime_type_conversion("application/msword")).to eq "Microsoft Word"
      expect(helper.mime_type_conversion("application/vnd.openxmlformats-officedocument.wordprocessingml.document")).to eq "Microsoft Word"
      expect(helper.mime_type_conversion("something else")).to eq ""
    end

  end

end

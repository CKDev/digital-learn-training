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
end

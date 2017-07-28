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

end

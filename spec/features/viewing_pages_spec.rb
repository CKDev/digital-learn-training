require "feature_helper"

feature "Users can view CMS pages" do

  scenario "any xss should be sanitized", js: true do
    html_body = <<~BODY
      <p>
        Body with some XSS
        <script>alert("XSS!")</script>
      </p>
    BODY
    @page = FactoryGirl.create(:page, body: html_body, pub_status: "published")
    visit page_path(@page)
    assert_no_alerts([:alert])
  end

end

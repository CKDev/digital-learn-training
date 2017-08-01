require "feature_helper"

feature "Users can view CMS pages" do

  scenario "any xss should be sanitized", js: true do
    html_body = <<~BODY
      <p>
        Body with some XSS
        <script>alert("XSS!")</script>
      </p>
    BODY
    @page = FactoryGirl.create(:page, body: html_body)
    visit page_path(@page)
    assert_no_alerts([:alert])
  end

  scenario "published pages should show in the footer" do
    @page1 = FactoryGirl.create(:page, title: "AAA")
    @page2 = FactoryGirl.create(:page, title: "BBB", pub_status: "draft")
    @page3 = FactoryGirl.create(:page, title: "CCC")
    @page4 = FactoryGirl.create(:page, title: "ZZZ")
    visit root_path
    within "footer" do
      expect(page).to have_content "AAA"
      expect(page).to have_content "CCC"
      expect(page).to have_content "ZZZ"
    end
  end

end

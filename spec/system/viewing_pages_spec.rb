require 'feature_helper'

feature 'Users can view CMS pages', type: :system do
  scenario 'any xss should be sanitized', :js do
    html_body = <<~BODY
      <p>
        Body with some XSS
        <script>alert("XSS!")</script>
      </p>
    BODY
    page = FactoryBot.create(:page, body: html_body)
    visit page_path(page)
    expect(alert_present?).to be_falsey
  end

  scenario 'published pages should show in the footer' do
    FactoryBot.create(:page, title: 'AAA')
    FactoryBot.create(:page, title: 'BBB', pub_status: 'D')
    FactoryBot.create(:page, title: 'CCC')
    FactoryBot.create(:page, title: 'ZZZ')
    visit root_path
    within 'footer' do
      expect(page).to have_content 'AAA'
      expect(page).to have_content 'CCC'
      expect(page).to have_content 'ZZZ'
    end
  end
end

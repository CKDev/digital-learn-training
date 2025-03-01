require 'feature_helper'

feature 'Admins can manage CMS pages' do

  before do
    @admin = create(:admin)
    log_in @admin
  end

  scenario 'can view CMS page index' do
    visit admin_pages_path
    click_link 'CMS Pages'
    expect(current_path).to eq(admin_pages_path)
    expect(page).to have_content 'Page Title'
  end

  scenario 'can add a new CMS page' do
    visit admin_pages_path
    click_link 'Add a New CMS Page'
    expect(current_path).to eq new_admin_page_path
    find('#page_title').set('New Title')
    find('#page_body').set('<p>Some page copy...</p>')
    find('#page_author').set('Admin-author')
    find('#page_seo_title').set('SEO Title')
    find('#page_meta_desc').set('Meta Desc')
    click_button 'Save CMS Page'
    expect(current_path).to eq admin_pages_path
    expect(page).to have_content 'New Title'
  end

  scenario 'cannot add a new CMS page with missing information' do
    visit admin_pages_path
    click_link 'Add a New CMS Page'
    click_button 'Save CMS Page'
    expect(page).to have_content 'The following errors'
  end

  scenario 'can edit an existing CMS page' do
    @page = create(:page)
    visit admin_pages_path
    within 'main' do
      click_link @page.title
    end
    expect(current_path).to eq edit_admin_page_path(@page)
    find('#page_title').set('Updated Title')
    click_button 'Save CMS Page'
    expect(current_path).to eq admin_pages_path
    within 'main' do
      expect(page).to have_content 'Updated Title'
    end
  end

end

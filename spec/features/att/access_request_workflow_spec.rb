require "feature_helper"

feature "User access request" do
  let!(:att) { FactoryBot.create(:att) }

  before :each do
    switch_to_subdomain 'training.att'
  end

  scenario 'user requests access' do
    visit '/'
    click_link('Login as Collaborator')

    # Log in page
    expect(page).to have_content('Log in')
    expect(page).to have_content("Don't have a collaborator account?")
    click_link_or_button('Request Access')

    # Access request page
    expect(page).to have_current_path(new_access_request_path)
    expect(page).to have_content('Request Collaborator Access')
    
    # Access Request Form
    fill_in 'Full Name', with: 'Steve Smith'
    fill_in 'Organization', with: 'Good Collaborators Inc.'
    fill_in 'Email', with: 'steve@gc.com'
    fill_in 'Phone Number', with: '1231231234'
    # expect(page).to have_content('AT&T Point of Contact info (if applicable)')
    fill_in 'AT&T Point of Contact first and last name (if applicable)', with: 'Some Contact'
    fill_in 'AT&T Point of Contact email address (if applicable)', with: 'poc@att.com'
    fill_in 'Please describe your reasons for reaching out', with: 'I would like to help design content'
    click_link_or_button 'Submit Access Request'
    expect(page).to have_current_path(new_user_session_path)
    expect(page).to have_content 'Your request for access has been submitted. If approved, you will receive an email invitation to set up your account.'
  end

  scenario 'admin sends user invite' do
  end

  scenario 'user accepts invitation' do
  end

  scenario 'existing approved user signs in with credentials' do
  end
end
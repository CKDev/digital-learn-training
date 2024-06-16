require "feature_helper"

feature "User access request" do
  let!(:att) { FactoryBot.create(:att) }

  before :each do
    switch_to_subdomain 'training.att'
  end

  after :each do
    reset_subdomain
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
    expect(page).to have_content('AT&T Point of Contact info')
    fill_in 'Point of Contact First Name', with: 'Some Contact'
    fill_in 'Point of Contact Email address', with: 'poc@att.com'
    fill_in 'Please provide a brief explanation for requesting access to materials', with: 'I would like to help design content'
    click_link_or_button 'Submit Access Request'
    expect(page).to have_current_path(new_user_session_path)
    expect(page).to have_content 'Your request for access has been submitted. If approved, you will receive an email invitation to set up your account.'
  end

  scenario 'admin sends user invite' do
  end
  
  scenario "user accepts invitation" do
    email = 'test@example.com'
    User.invite!(email: email) do |u|
      u.skip_invitation = true
      u.send(:generate_invitation_token)
      @token = u.raw_invitation_token
    end

    visit accept_user_invitation_path(invitation_token: @token, subdomain: 'att')
    expect(page).to have_content("Create Collaborator Account")

    expect(page).to have_field("Email Address", with: email, disabled: true)
    fill_in "First Name", with: "Test"
    fill_in "Last Name", with: "User"
    fill_in "Password", with: "asdfasdf"
    fill_in "Password confirmation", with: "asdfasdf"
    fill_in "Phone", with: "1231231234"
    fill_in "Organization Name", with: "Test Organization"
    fill_in "Organization City", with: "Denver"
    select "Colorado", from: "Organization State"
    fill_in "AT&T Point of Contact first and last name", with: "Some Contact"
    fill_in "AT&T Point of Contact email address", with: "test@att.com"
    expect(page).to have_content "By accessing these materials, data, and documents (\"Content\") contained herein,"
    check "I accept these Terms and Conditions"
    click_button "Create Account"
    expect(page).to have_current_path(root_path)
    expect(page).to have_content("Your account has been created. You are now signed in.")
    expect(page).to have_content("I understand and agree that any unauthorized modification, alteration")
    click_link 'Dismiss'
    expect(page).not_to have_content("I understand and agree that any unauthorized modification, alteration")
  end

  scenario 'existing approved user signs in with credentials' do
  end
end
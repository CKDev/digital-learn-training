require "feature_helper"

feature "User accepts invitation" do
  let(:email) { 'test@example.com' }

  before do
    User.invite!(email: email) do |u|
      u.skip_invitation = true
      u.send(:generate_invitation_token)
      @token = u.raw_invitation_token
    end
  end

  scenario "user accepts invitation" do
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
  end
end

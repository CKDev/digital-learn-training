require "feature_helper"

feature "ATT User visits app" do
  before :each do
    FactoryBot.create(:att)
    switch_to_subdomain 'training.att'
  end

  after :each do
    reset_subdomain
  end

  scenario "Sees login page at root path" do
    visit root_path

    expect(page).to have_link 'Login with AT&T SSO (AT&T Employees Only)'
    expect(page).to have_link 'Login as Collaborator'
    expect(page).not_to have_content 'You need to sign in or sign up before continuing.'
  end

  scenario "Attempts to visit page behind login wall" do
    visit courses_path

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
    expect(current_path).to match('/att/login')
  end

  scenario "Admin attempts to visit admin page with att subdomain" do
    visit admin_root_path

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
    expect(current_path).to match('/users/sign_in')
  end
end

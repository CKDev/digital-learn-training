require "feature_helper"

feature "ATT User visits app" do
  before :each do
    FactoryGirl.create(:att)
    switch_to_subdomain 'training.att'
  end

  scenario "Sees login page at root path" do
    visit root_path

    expect(page).to have_button 'Sign In with AT&T CSP'
    expect(page).not_to have_content 'You need to sign in or sign up before continuing.'
    click_button('Sign In with AT&T CSP')
    expect(current_path).to match('dev-3836710.okta.com/login')
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

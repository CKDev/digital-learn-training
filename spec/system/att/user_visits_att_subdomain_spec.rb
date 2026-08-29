require 'feature_helper'

feature 'ATT User visits app' do
  before do
    create(:att, settings: { access_requests_enabled: true, authentication_required: true })
    switch_to_subdomain 'training.att'
  end

  after do
    reset_subdomain
  end

  scenario 'Sees access-request and SSO links on the sign-in page', :js do
    visit new_user_session_path

    expect(page).to have_content("Don't have a collaborator account?")
    expect(page).to have_link('Request Access', href: new_access_request_path)
    expect(page).to have_link('Login with AT&T SSO', href: new_saml_user_session_path)
    expect(page).not_to have_content 'You need to sign in or sign up before continuing.'
  end

  scenario 'Attempts to visit page behind login wall' do
    visit root_path

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
    expect(current_path).to eq('/users/sign_in')
  end

  scenario 'Admin attempts to visit admin page with att subdomain' do
    visit admin_root_path

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
    expect(current_path).to match('/users/sign_in')
  end
end

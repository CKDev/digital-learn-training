require 'feature_helper'

feature 'Admins can send invitations' do
  it "doesn't allow non-admin user access" do
    user = create(:user)
    log_in user
    visit new_user_invitation_path
    expect(page).to have_current_path(root_path)
    expect(page).to have_content('You are not authorized to view this page.')
  end

  context 'when authenticated admin' do
    let(:admin) { create(:admin) }

    before do
      create(:att)
      log_in admin
      click_link 'Admin Dashboard'
    end

    it 'visits invitation page from admin portal' do
      click_link 'Invite Collaborator'
      expect(page).to have_current_path(new_user_invitation_path)
      expect(page).to have_content('Invite Collaborator to DigitalLearn')
      expect(page).to have_content('This feature currently applies to the AT&T training subdomain only.')
      fill_in 'Email', with: 'test_user@example.com'
      click_button 'Send Invitation'
      expect(page).to have_current_path(admin_root_path)
      expect(page).to have_content('An invitation email has been sent to test_user@example.com.')
    end

    it 'visits invitation page from email link' do
      access_request = create(:access_request)
      visit new_user_invitation_path(access_request_id: access_request.id)
      expect(page).to have_field('Email', with: access_request.email)
    end
  end
end

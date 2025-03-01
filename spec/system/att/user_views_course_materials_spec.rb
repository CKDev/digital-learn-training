require 'feature_helper'

feature 'ATT User views course materials' do
  let!(:att) { create(:att) }
  let(:user) { create(:user, provider: :saml) }

  before do
    switch_to_subdomain 'training.att'
    login_as(user, scope: :user)
  end

  after do
    reset_subdomain
  end

  context 'when no categories' do
    scenario 'via homepage' do
      visit root_path

      expect(page).to have_content('Training materials coming soon')
    end

    scenario 'via course materials page' do
      visit course_materials_path

      expect(page).to have_content('Training materials coming soon')
    end
  end

  context 'with categories' do
    let!(:category) { create(:category, organization: att) }

    scenario 'via homepage' do
      visit root_path

      expect(page).not_to have_content('Training materials coming soon')
      expect(page).to have_content(category.title)
    end

    scenario 'via course materials page' do
      visit course_materials_path

      expect(page).not_to have_content('Training materials coming soon')
      expect(page).to have_content(category.title)
    end
  end
end

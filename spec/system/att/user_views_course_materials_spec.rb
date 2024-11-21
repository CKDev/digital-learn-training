require "feature_helper"

feature "ATT User views course materials" do
  let!(:att) { FactoryBot.create(:att) }
  let(:user) { FactoryBot.create(:user, provider: :saml) }

  before :each do
    switch_to_subdomain 'training.att'
    login_as(user, scope: :user)
  end

  after :each do
    reset_subdomain
  end

  context 'no categories' do
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
    let!(:category) { FactoryBot.create(:category, organization: att) }

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

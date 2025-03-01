require 'feature_helper'

feature 'Users can view a course', :js do
  describe 'language tabs' do
    let!(:english_course) do
      FactoryBot.create(:course_material, title: 'English Course',
                                          pub_status: 'P',
                                          language: :en)
    end

    let!(:spanish_course) do
      FactoryBot.create(:course_material, title: 'El Curso de Español',
                                          pub_status: 'P',
                                          language: :es)
    end

    it 'toggles between english and spanish courses' do
      visit root_path
      expect(page).to have_selector('.tab-link.active', text: 'English')
      expect(page).not_to have_content(spanish_course.title)
      within('.language-tabs-header') do
        click_link 'Spanish'
      end
      expect(page).to have_selector('.tab-link.active', text: 'Spanish')
      expect(page).not_to have_content(english_course.title)
    end
  end

  context 'courses with hide_courses_on_homepage flag' do
    let(:normal_category) { FactoryBot.create(:category, title: 'Normal Category') }
    let(:collapsed_category) do
      FactoryBot.create(:category, title: 'Collapsed Category', hide_courses_on_homepage: true)
    end
    let!(:normal_cm) do
      FactoryBot.create(:course_material, title: 'Normal Course',
                                          pub_status: 'P',
                                          category: normal_category)
    end
    let!(:hidden_cm) do
      FactoryBot.create(:course_material, title: 'Hidden Course',
                                          pub_status: 'P',
                                          category: collapsed_category)
    end

    it 'hides course material listing for homepage collapse categories' do
      visit root_path
      expect(page).to have_content('Normal Category')
      expect(page).to have_content('Collapsed Category')
      expect(page).to have_content('Normal Course')
      expect(page).not_to have_content('Hidden Course')
      click_link 'Collapsed Category'
      expect(current_path).to eq(category_path(collapsed_category))
      expect(page).to have_content('Hidden Course')
    end
  end
end

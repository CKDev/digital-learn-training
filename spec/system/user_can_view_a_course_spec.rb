require 'feature_helper'

feature 'Users can view a course', :js do
  let(:category) { FactoryBot.create(:category) }
  let!(:course_material) { FactoryBot.create(:course_material, pub_status: 'P', category: category) }

  scenario 'published pages should show in the footer' do
    visit root_path

    # TODO: The title is no longer a link tag, we'll need to click the panel itself or the "VIEW COURSE MATERIALS" button
    click_link course_material.title
    expect(current_path).to eq course_material_path(course_material)
    expect(page).to have_content 'Contributed by'
    expect(page).to have_content 'Topics'
    expect(page).to have_content 'Get in touch'
    expect(page).to have_content 'There are no files.'
    expect(page).to have_content 'There are no image files.'
    expect(page).to have_content 'There are no video clips.'
  end
end

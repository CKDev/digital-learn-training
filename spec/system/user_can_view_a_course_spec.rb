require "feature_helper"

feature "Users can view a course" do
  let(:category1) { FactoryBot.create(:category) }
  let(:category2) { FactoryBot.create(:category2) }
  let!(:category1_material) { FactoryBot.create(:course_material, pub_status: "P", category: category1) }
  let!(:category2_material) { FactoryBot.create(:course_material, pub_status: "P", category: category2) }

  scenario "published pages should show in the footer" do
    visit root_path
    click_link category1_material.title
    expect(current_path).to eq course_material_path(category1_material)
    expect(page).to have_content "Contributed by"
    expect(page).to have_content "Topics"
    expect(page).to have_content "Get in touch"
    expect(page).to have_content "There are no files."
    expect(page).to have_content "There are no image files."
    expect(page).to have_content "There are no video clips."
  end
end

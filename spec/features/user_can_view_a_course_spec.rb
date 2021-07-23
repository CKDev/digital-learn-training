require "feature_helper"

feature "Users can view a course" do

  scenario "published pages should show in the footer" do
    @course_material = FactoryBot.create(:course_material, pub_status: "P")
    visit root_path
    click_link @course_material.category.title
    expect(current_path).to eq category_path(@course_material.category)
    click_link @course_material.title
    expect(current_path).to eq course_material_path(@course_material)
    expect(page).to have_content "Contributed by"
    expect(page).to have_content "Topics"
    expect(page).to have_content "Get in touch"
    expect(page).to have_content "There are no files."
    expect(page).to have_content "There are no image files."
    expect(page).to have_content "There are no video clips."
  end

end

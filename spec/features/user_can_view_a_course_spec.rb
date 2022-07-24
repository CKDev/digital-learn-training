require "feature_helper"

feature "Users can view a course" do
  context "single category" do
    let!(:course_material) { FactoryBot.create(:course_material, pub_status: "P") }

    scenario "redirects to category page" do
      visit root_path
      expect(current_path).to eq(category_path(course_material.category))
      click_link course_material.title
      expect(current_path).to eq course_material_path(course_material)
      expect(page).to have_content "Contributed by"
      expect(page).to have_content "Topics"
      expect(page).to have_content "Get in touch"
      expect(page).to have_content "There are no files."
      expect(page).to have_content "There are no image files."
      expect(page).to have_content "There are no video clips."
    end
  end

  context "multiple categories" do
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

  context "hide_courses_on_homepage flag" do
    let(:normal_category) { FactoryBot.create(:category, title: "Normal Category") }
    let(:collapsed_category) do
      FactoryBot.create(:category, title: "Collapsed Category", hide_courses_on_homepage: true)
    end
    let!(:normal_cm) do
      FactoryBot.create(:course_material, title: "Normal Course",
                                          pub_status: "P",
                                          category: normal_category)
    end
    let!(:hidden_cm) do
      FactoryBot.create(:course_material, title: "Hidden Course",
                                          pub_status: "P",
                                          category: collapsed_category)
    end

    it "hides course material listing for homepage collapse categories" do
      visit root_path
      expect(page).to have_content("Normal Category")
      expect(page).to have_content("Collapsed Category")
      expect(page).to have_content("Normal Course")
      expect(page).not_to have_content("Hidden Course")
      click_link "Collapsed Category"
      expect(current_path).to eq(category_path(collapsed_category))
      expect(page).to have_content("Hidden Course")
    end
  end
end

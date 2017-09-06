require "feature_helper"

feature "Admins can manage categories pages" do

  before :each do
    @category = FactoryGirl.create(:category)
    @admin = FactoryGirl.create(:admin)
    log_in @admin
  end

  scenario "can view categories index" do
    visit admin_root_path
    click_link "Course Categories"
    expect(current_path).to eq(admin_categories_path)
    expect(page).to have_content "Course Categories"
  end

  scenario "can add new Course category" do
    visit admin_categories_path
    click_link "Add a New Course Category"
    expect(current_path).to eq new_admin_category_path
    find("#category_title").set("New Category Title")
    find("#category_description").set("Description")
    select @category.tag
    click_link "Add Subcategory"
    fill_in "category[sub_categories_attributes][0][title]", with: "Subcategory Title"
    click_button "Save Category"
    expect(current_path).to eq admin_categories_path
    expect(page).to have_content "New Category Title"
  end

  scenario "cannot add a new Category page with missing information" do
    visit new_admin_category_path
    click_button "Save Category"
    expect(page).to have_content "The following errors"
  end

  scenario "can edit an existing Category page" do
    visit admin_categories_path
    within "main" do
      click_link @category.title
    end
    expect(current_path).to eq edit_admin_category_path(@category)
    find("#category_title").set("Updated Title")
    click_button "Save Category"
    expect(current_path).to eq admin_categories_path
    within "main" do
      expect(page).to have_content "Updated Title"
    end
  end

end

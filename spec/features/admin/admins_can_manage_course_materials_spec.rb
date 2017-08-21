require "feature_helper"

feature "Admins can manage course materials pages" do

  before :each do
    @category = FactoryGirl.create(:category)
    @admin = FactoryGirl.create(:admin)
    log_in @admin
  end

  scenario "can view course materials page index" do
    visit admin_root_path
    click_link "Course Materials"
    expect(current_path).to eq(admin_course_materials_path)
    expect(page).to have_content "Course Materials"
  end

  scenario "can add new Course Materials" do
    visit admin_course_materials_path
    click_link "Add New Course Materials"
    expect(current_path).to eq new_admin_course_material_path
    find("#course_material_title").set("New Course Materials Title")
    find("#course_material_contributor").set("Alejandro Brinkster")
    find("#course_material_summary").set("Summary")
    find("#course_material_description").set("Description")
    select @category.title
    click_button "Save Course Materials"
    expect(current_path).to eq admin_course_materials_path
    expect(page).to have_content "New Course Materials Title"
  end

  scenario "cannot add a new Course Materials page with missing information" do
    visit new_admin_course_material_path
    click_button "Save Course Materials"
    expect(page).to have_content "The following errors"
  end

  scenario "can edit an existing Course Materials page" do
    @course_material = FactoryGirl.create(:course_material)
    visit admin_course_materials_path
    within "main" do
      click_link @course_material.title
    end
    expect(current_path).to eq edit_admin_course_material_path(@course_material)
    find("#course_material_title").set("Updated Title")
    click_button "Save Course Materials"
    expect(current_path).to eq admin_course_materials_path
    within "main" do
      expect(page).to have_content "Updated Title"
    end
  end

end

require "feature_helper"

feature "Admins can manage course pages" do

  before :each do
    @category = FactoryBot.create(:category)
    @admin = FactoryBot.create(:admin)
    log_in @admin
  end

  scenario "can view course page index" do
    visit admin_root_path
    click_link "Courses"
    expect(current_path).to eq(admin_course_materials_path)
    expect(page).to have_content "Courses"
  end

  scenario "can add new Courses" do
    visit admin_course_materials_path
    click_link "Add New Course"
    expect(current_path).to eq new_admin_course_material_path
    find("#course_material_title").set("New Course Title")
    find("#course_material_contributor").set("Alejandro Brinkster")
    find("#course_material_summary").set("Summary")
    find("#course_material_description").set("Description")
    select @category.title
    click_button "Save Course"
    expect(current_path).to eq admin_course_materials_path
    expect(page).to have_content "New Course Title"
  end

  scenario "sees correct category options" do
    att = FactoryBot.create(:att)
    FactoryBot.create(:category, title: "AT&T category", organization: att)
    FactoryBot.create(:category, title: "Non-org category")
    visit admin_course_materials_path
    click_link "Add New Course"
    expected_options = ["AT&T category (AT&T)", "Non-org category"]
    expect(page).to have_select "Category", with_options: expected_options
  end

  scenario "cannot add a new Course page with missing information" do
    visit new_admin_course_material_path
    click_button "Save Course"
    expect(page).to have_content "The following errors"
  end

  scenario "can edit an existing Course page" do
    @course_material = FactoryBot.create(:course_material)
    material_file = FactoryBot.create(:course_material_file, course_material: @course_material)
    visit admin_course_materials_path
    within "main" do
      click_link @course_material.title
    end
    expect(current_path).to eq edit_admin_course_material_path(@course_material)
    find("#course_material_title").set("Updated Title")
    click_button "Save Course"
    expect(current_path).to eq admin_course_materials_path
    within "main" do
      expect(page).to have_content "Updated Title"
    end
  end

end

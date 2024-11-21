require "feature_helper"

feature "Users can complete a training" do

  scenario "published pages should show in the footer" do
    @course = FactoryBot.create(:course, :with_lessons)
    visit root_path
    click_link @course.title
    expect(current_path).to eq course_path(@course)
    click_link "Start Training"
    expect(current_path).to eq course_lesson_path(@course, @course.lessons.first)
    click_link "Skip to next Activity >>"
    expect(current_path).to eq course_lesson_path(@course, @course.lessons.second)
    click_link "Skip to next Activity >>"
    expect(current_path).to eq course_lesson_path(@course, @course.lessons.third)
    expect(page).to have_content "100% Complete"
  end

end

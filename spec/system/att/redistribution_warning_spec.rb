require "feature_helper"

feature "User access request" do
  let!(:att) { FactoryBot.create(:att) }
  let(:user) { FactoryBot.create(:user, :with_collaborator_profile) }
  let(:warning_message) do
    "I understand and agree that any unauthorized modification, alteration, " +
    "or revision of the Content is strictly prohibited without the express written consent of AT&T. " +
    "For permissions or inquiries, I understand that I should contact AT&T directly."
  end

  before :each do
    switch_to_subdomain "training.att"
    log_in user
  end

  scenario "shows warning until dismissal" do
    expect(page).to have_current_path(root_path, ignore_query: true)
    expect(page).to have_content(warning_message)
    click_link "Courses"
    expect(page).to have_content(warning_message)
    click_link "Dismiss"
    expect(current_path).to eq(course_materials_path)
    expect(page).not_to have_content(warning_message)
  end
end
require "feature_helper"

feature "User views category index" do
  context "User is part of an organization" do
    let(:att) { FactoryBot.create(:att) }
    let(:user) { FactoryBot.create(:user, provider: :saml) }
    let(:category) { FactoryBot.create(:category, organization: att) }

    before do
      switch_to_subdomain "training.att"
      login_as(user, scope: :user)
    end

    after do
      reset_subdomain
    end

    scenario "no course materials in category" do
      visit category_path(category)
      expect(page).to have_content("There are currently no available courses.")
    end

    scenario "course materials in category" do
      course_material = FactoryBot.create(:course_material, pub_status: "P", category: category)
      visit category_path(category)
      expect(page).not_to have_content("There are currently no available courses.")
      expect(page).to have_content(course_material.title)
    end
  end

  context "user is not part of an organization" do
    let(:user) { FactoryBot.create(:user) }
    let(:category) { FactoryBot.create(:category) }

    before do
      login_as(user, scope: :user)
    end

    scenario "no course materials in category" do
      visit category_path(category)
      expect(page).not_to have_content("AT&T Employees")
      expect(page).to have_content("There are currently no available courses.")
    end
  end
end

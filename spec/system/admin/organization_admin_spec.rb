require "feature_helper"

feature "Organization admin can sign in and view features" do
  let(:organization) { create(:organization) }
  let(:org_admin) { create(:user) }

  before do
    org_admin.add_role(:organization_admin, organization)
    switch_to_subdomain(organization.subdomain)
  end

  it "allows org admin to sign in", :js do
    visit root_path
    click_link "Admin Sign In"
    fill_in "Email", with: org_admin.email
    fill_in "Password", with: org_admin.password
    click_link_or_button "Sign In"
    expect(page).to have_content("Add New Course")
    expect(page).to have_content("Sign Out")
  end
end

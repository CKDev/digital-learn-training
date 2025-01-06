require "rails_helper"

describe HomeController do
  it "shows the homepage" do
    get :index
    expect(response).to redirect_to course_materials_path
  end

  describe "non-organization subdomain" do
    let(:org) { FactoryBot.create(:att) }
    let!(:no_org_category) { FactoryBot.create(:category) }
    let!(:organization_category) { FactoryBot.create(:category, organization: org) }

    it "sets all non-org courses" do
      get :index
      expect(assigns(:categories)).to contain_exactly(no_org_category)
    end
  end

  describe "organization subdomain" do
    let(:org) { FactoryBot.create(:att) }
    let(:user) { FactoryBot.create(:user) }
    let!(:att_category1) { FactoryBot.create(:category, organization: org) }
    let!(:att_category2) { FactoryBot.create(:category, organization: org) }
    let!(:non_att_category) { FactoryBot.create(:category) }

    before do
      @request.host = "#{org.subdomain}.dltest.org"
      sign_in user
    end

    it "sets correct categories for organization subdomain" do
      get :index
      expect(assigns(:categories)).to contain_exactly(att_category1, att_category2)
    end
  end
end

require "rails_helper"

describe CourseMaterialsController do
  describe "GET #index" do
    describe "non-organization subdomain" do
      let(:org) { FactoryBot.create(:att) }
      let!(:no_org_category) { FactoryBot.create(:category) }

      before do
        FactoryBot.create(:category, organization: org)
      end

      it "sets all non-org courses" do
        get :index
        expect(assigns(:categories)).to contain_exactly(no_org_category)
      end
    end

    describe "organization subdomain" do
      let(:org) { FactoryBot.create(:att) }
      let(:user) { FactoryBot.create(:user) }
      let!(:att_sa_category) { FactoryBot.create(:category, organization: org, title: "Software & Applications") }
      let!(:att_jobs_category) { FactoryBot.create(:category, organization: org, title: "Jobs & Career") }

      before do
        FactoryBot.create(:category)

        @request.host = "#{org.subdomain}.dltest.org" # rubocop:disable RSpec/InstanceVariable
        sign_in user
      end

      it "sets correct categories for organization subdomain" do
        get :index
        expect(assigns(:categories)).to contain_exactly(att_sa_category, att_jobs_category)
      end
    end
  end

  describe "GET #show" do
    it "assigns the last 3 courses in the same category, that are published, and not self" do
      category = FactoryBot.create(:category)
      other_category = FactoryBot.create(:category, title: "Another Category")
      course_material1 = FactoryBot.create(:course_material, pub_status: "P", category: category)
      course_material2 = FactoryBot.create(:course_material, pub_status: "P", category: category)
      course_material3 = FactoryBot.create(:course_material, pub_status: "P", category: category)
      course_material4 = FactoryBot.create(:course_material, pub_status: "P", category: category)
      FactoryBot.create(:course_material, pub_status: "P", category: other_category)
      FactoryBot.create(:course_material, pub_status: "D", category: category)
      get :show, params: { id: course_material1.id }
      expect(assigns(:course_materials)).to contain_exactly(course_material2, course_material3, course_material4)
    end
  end
end

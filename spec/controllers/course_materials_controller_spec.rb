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

    describe "att subdomain" do
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

    describe "organization subdomain" do
      let(:org) { FactoryBot.create(:organization, subdomain: 'test') }
      let(:user) { FactoryBot.create(:user) }
      let(:org_sa_category) { FactoryBot.create(:category, organization: org, title: "Software & Applications") }
      let(:org_jobs_category) { FactoryBot.create(:category, organization: org, title: "Jobs & Career") }

      before do
        create(:course_material, category: org_sa_category)
        create(:course_material, category: org_jobs_category)

        @request.host = "#{org.subdomain}.dltest.org" # rubocop:disable RSpec/InstanceVariable
        sign_in user
      end

      it "assigns categories data" do
        get :index
        expected_data = {
          categories: [org_sa_category.to_props(include_materials: true), org_jobs_category.to_props(include_materials: true)],
          initialCategoryFriendlyId: nil,
          initialLanguage: nil
        }
        expect(assigns(:course_materials_data)).to eq(expected_data)
      end

      it "includes imported courses in categories" do
        main_site_category = create(:category, title: "Getting Started")
        main_site_accounts = create(:course_material, title: "Accounts and Passwords", category: main_site_category)
        main_site_os = create(:course_material, title: "Operating Systems")

        org.imported_course_materials << main_site_accounts

        get :index

        imported_category_with_course_data = main_site_category.to_props.merge({ courseMaterials: [main_site_accounts.to_props] })

        expected_data = {
          categories: [
            org_sa_category.to_props(include_materials: true),
            org_jobs_category.to_props(include_materials: true),
            imported_category_with_course_data
          ],
          initialCategoryFriendlyId: nil,
          initialLanguage: nil
        }

        expect(assigns(:course_materials_data)).to eq(expected_data)
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

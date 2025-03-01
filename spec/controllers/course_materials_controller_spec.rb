require 'rails_helper'

describe CourseMaterialsController do
  describe 'GET #index' do
    describe 'non-organization subdomain' do
      let(:org) { create(:att) }
      let!(:category_with_published_courses) { create(:category) }

      before do
        create(:category, organization: org)
        create(:category)
        unpublished_category = create(:category)
        create(:course_material, pub_status: 'P', category: category_with_published_courses)
        create(:course_material, pub_status: 'P', category: category_with_published_courses)
        create(:course_material, pub_status: 'D', category: unpublished_category)
        create(:course_material, pub_status: 'A', category: unpublished_category)
      end

      it 'sets all non-org categories with courses' do
        get :index
        expect(assigns(:categories)).to contain_exactly(category_with_published_courses)
      end
    end

    describe 'att subdomain' do
      let(:org) { create(:att) }
      let(:user) { create(:user) }
      let!(:att_sa_category) { create(:category, organization: org, title: 'Software & Applications') }
      let!(:att_jobs_category) { create(:category, organization: org, title: 'Jobs & Career') }

      before do
        create(:category)
        create(:course_material, pub_status: 'P', category: att_sa_category)
        create(:course_material, pub_status: 'P', category: att_jobs_category)

        @request.host = "#{org.subdomain}.dltest.org" # rubocop:disable RSpec/InstanceVariable
        sign_in user
      end

      it 'sets correct categories for organization subdomain' do
        get :index
        expect(assigns(:categories)).to contain_exactly(att_sa_category, att_jobs_category)
      end
    end

    describe 'organization subdomain' do
      let(:org) { create(:organization, subdomain: 'test') }
      let(:user) { create(:user) }
      let(:org_sa_category) { create(:category, organization: org, title: 'Software & Applications') }
      let(:org_jobs_category) { create(:category, organization: org, title: 'Jobs & Career') }

      before do
        create(:course_material, pub_status: 'P', category: org_sa_category)
        create(:course_material, pub_status: 'P', category: org_jobs_category)

        @request.host = "#{org.subdomain}.dltest.org" # rubocop:disable RSpec/InstanceVariable
        sign_in user
      end

      it 'assigns categories data' do
        get :index
        expected_data = {
          categories: [org_sa_category.to_props(include_materials: true), org_jobs_category.to_props(include_materials: true)],
          initialCategoryFriendlyId: nil,
          initialLanguage: nil
        }
        expect(assigns(:course_materials_data)).to eq(expected_data)
      end

      it 'includes imported courses in categories' do
        main_site_category = create(:category, title: 'Getting Started')
        main_site_accounts = create(:course_material, title: 'Accounts and Passwords', category: main_site_category)
        create(:course_material, title: 'Operating Systems')

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

  describe 'GET #show' do
    it 'assigns the last 3 courses in the same category, that are published, and not self' do
      category = create(:category)
      other_category = create(:category, title: 'Another Category')
      course_material1 = create(:course_material, pub_status: 'P', category: category)
      course_material2 = create(:course_material, pub_status: 'P', category: category)
      course_material3 = create(:course_material, pub_status: 'P', category: category)
      course_material4 = create(:course_material, pub_status: 'P', category: category)
      create(:course_material, pub_status: 'P', category: other_category)
      create(:course_material, pub_status: 'D', category: category)
      get :show, params: { id: course_material1.id }
      expect(assigns(:course_materials)).to contain_exactly(course_material2, course_material3, course_material4)
    end
  end
end

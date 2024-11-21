require "rails_helper"

describe CourseMaterialsController do

  describe "GET #index" do

    it "assigns the different categories by tag" do
      @category1 = FactoryBot.create(:category, tag: "Hardware")
      @category2 = FactoryBot.create(:category, tag: "Software & Applications")
      @category3 = FactoryBot.create(:category, tag: "Job & Career")
      @category4 = FactoryBot.create(:category, tag: "Other")
      @course_material = FactoryBot.create(:course_material, title: "Course Templates", category: @category4)
      @sub_category = FactoryBot.create(:sub_category, category: @category1)
      get :index
      expect(assigns(:categories)).to contain_exactly(@category1, @category2, @category3, @category4)
      expect(assigns(:software_and_applications)).to contain_exactly(@category2)
      expect(assigns(:job_and_career)).to contain_exactly(@category3)
      expect(assigns(:blank_template)).to eq @course_material
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

  describe "GET #show" do

    it "assigns the last 3 courses in the same category, that are published, and not self" do
      @category1 = FactoryBot.create(:category2)
      @category2 = FactoryBot.create(:category2)
      @course_material1 = FactoryBot.create(:course_material, pub_status: "P", category: @category1)
      @course_material2 = FactoryBot.create(:course_material, pub_status: "P", category: @category1)
      @course_material3 = FactoryBot.create(:course_material, pub_status: "P", category: @category1)
      @course_material4 = FactoryBot.create(:course_material, pub_status: "P", category: @category1)
      @course_material5 = FactoryBot.create(:course_material, pub_status: "P", category: @category2)
      @course_material5 = FactoryBot.create(:course_material, pub_status: "D", category: @category1)
      get :show, params: { id: @course_material1.id }
      expect(assigns(:course_materials)).to contain_exactly(@course_material2, @course_material3, @course_material4)
    end

  end

end

require "rails_helper"

describe Admin::CourseMaterialImportsController do
  let(:organization) { create(:organization, subdomain: "test") }
  let(:org_admin) { create(:user) }
  let!(:course_material) { create(:course_material) }
  let!(:imported_course_material) { create(:course_material) }
  let(:org_category) { create(:category, organization: organization) }
  let!(:org_course_material) { create(:course_material, category: org_category) }

  before do
    org_admin.add_role(:organization_admin, organization)
    organization.imported_course_materials << imported_course_material
    @request.host = "#{organization.subdomain}.dltest.org" # rubocop:disable RSpec/InstanceVariable

    sign_in org_admin
  end

  describe "GET #index" do
    it "assigns all imported and importable course_materials" do
      get :index
      expect(assigns[:course_materials]).to contain_exactly(course_material, imported_course_material)
      expect(assigns[:imported_course_materials]).to contain_exactly(imported_course_material)
    end
  end

  describe "POST #create" do
    it "imports course_material to organization" do
      expect do
        post :create, params: { course_material_id: course_material.id }, xhr: true, format: :json
      end.to change { organization.imported_course_materials.count }.by(1)

      expect(response).to have_http_status :created
      expect(organization.imported_course_materials).to include(course_material)
    end
  end

  describe "DELETE #destroy" do
    it "removes imported course" do
      expect do
        delete :destroy, params: { id: imported_course_material.id }, xhr: true, format: :json
      end.to change { organization.imported_course_materials.count }.by(-1)

      expect(response).to have_http_status :ok
    end
  end
end

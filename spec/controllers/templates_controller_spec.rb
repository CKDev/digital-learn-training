require "rails_helper"

describe TemplatesController do
  describe "GET #index" do
    context "when template course material exists" do
      it "returns a 200" do
        FactoryBot.create(:course_material, title: "Course Templates")

        get :index
        expect(response).to have_http_status(:ok)
      end
    end

    context "when template course material does not exist" do
      it "redirects to root" do
        get :index
        expect(response).to redirect_to(root_path)
      end
    end
  end
end

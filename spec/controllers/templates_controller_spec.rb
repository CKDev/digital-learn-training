require "rails_helper"

describe TemplatesController do
  describe "GET #index" do
    it "returns a 200" do
      get :index
      expect(response).to have_http_status :ok
    end
  end
end

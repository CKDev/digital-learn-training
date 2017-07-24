require "rails_helper"

describe HomeController do

  it "should show the homepage" do
    get :index
    expect(response).to have_http_status(:success)
  end

end

require 'rails_helper'

describe HomeController do
  it 'shows the homepage' do
    get :index
    expect(response).to redirect_to course_materials_path
  end
end

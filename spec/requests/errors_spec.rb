require 'rails_helper'

RSpec.describe 'Error pages', type: :request do
  let(:organization) { create(:organization, settings: { authentication_required: true }) }

  before { host! "#{organization.subdomain}.test.com" }

  it 'renders the 404 page for signed-out users on an organization that requires authentication' do
    get '/404'

    expect(response).to have_http_status(:not_found)
  end
end

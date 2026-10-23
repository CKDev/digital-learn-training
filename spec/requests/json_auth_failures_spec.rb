require 'rails_helper'

RSpec.describe 'JSON authentication failures', type: :request do
  let(:json_headers) { { 'Accept' => 'application/json' } }

  before { host! "#{organization.subdomain}.test.com" }

  context 'when the organization requires authentication' do
    let(:organization) { create(:organization, settings: { authentication_required: true }) }

    it 'returns a JSON 401 instead of redirecting to sign in' do
      get '/course_materials', headers: json_headers

      expect(response).to have_http_status(:unauthorized)
      expect(response.parsed_body['error']).to be_present
    end
  end

  context 'when signing in while already signed in' do
    let(:organization) { create(:organization) }
    let(:user) { create(:user) }

    before { sign_in user }

    it 'returns a JSON 403 with a redirect path' do
      post '/users/sign_in', params: { user: { email: user.email, password: 'asdfasdf' } }, as: :json

      expect(response).to have_http_status(:forbidden)
      expect(response.parsed_body['error']).to be_present
      expect(response.parsed_body['redirectPath']).to be_present
    end
  end

  context 'when a signed-in user lacks access to a trainers-only organization' do
    let(:organization) { create(:organization, settings: { trainers_only: true }) }
    let(:user) { create(:user) }

    before { sign_in user }

    it 'returns a JSON 403 instead of redirecting' do
      get '/course_materials', headers: json_headers

      expect(response).to have_http_status(:forbidden)
      expect(response.parsed_body['error']).to be_present
    end
  end
end

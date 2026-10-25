require 'rails_helper'

RSpec.describe 'User invitations', type: :request do
  describe 'PUT /users/invitation (accept)' do
    let!(:att) { create(:att) }
    let(:user) { User.invite!(email: 'collaborator@example.com') }

    let(:params) do
      {
        user: {
          invitation_token: user.raw_invitation_token,
          password: 'password123',
          password_confirmation: 'password123',
          collaborator_profile_attributes: {
            first_name: 'Jane',
            last_name: 'Doe',
            organization_name: 'Test Org',
            organization_city: 'Denver',
            organization_state: 'CO',
            poc_name: 'POC',
            poc_email: 'poc@example.com',
            terms_of_service: '1'
          }
        }
      }
    end

    before { host! 'att.test.com' }

    it 'assigns the collaborator role for the current organization' do
      put '/users/invitation', params: params, as: :json

      expect(response).to have_http_status(:ok)
      expect(user.reload.has_role?(:collaborator, att)).to be true
    end
  end
end

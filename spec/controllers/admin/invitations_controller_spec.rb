require 'rails_helper'

describe InvitationsController do
  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'PUT update' do
    let(:email) { 'test@example.com' }
    let(:user) { User.find_by(email: email) }
    let(:valid_acceptance_params) do
      {
        user: {
          invitation_token: @token,
          password: 'asdfasdf',
          password_confirmation: 'asdfasdf',
          collaborator_profile_attributes: {
            first_name: 'Test',
            last_name: 'User',
            phone: '1231231234',
            organization_name: 'Org Name',
            organization_city: 'City',
            organization_state: 'CO',
            poc_name: 'Contact',
            poc_email: 'contact@example.com',
            terms_of_service: '1'
          }
        }
      }
    end

    before do
      User.invite!(email: email) do |u|
        u.skip_invitation = true
        u.send(:generate_invitation_token)
        @token = u.raw_invitation_token
      end
    end

    it 'creates a collaborator profile' do
      expect do
        put :update, params: valid_acceptance_params
      end.to change(CollaboratorProfile, :count).by(1)

      new_profile = CollaboratorProfile.last
      expect(new_profile.user).to eq(user)
      expect(new_profile.first_name).to eq('Test')
      expect(new_profile.last_name).to eq('User')
      expect(new_profile.phone).to eq('1231231234')
      expect(new_profile.organization_name).to eq('Org Name')
      expect(new_profile.organization_city).to eq('City')
      expect(new_profile.organization_state).to eq('CO')
      expect(new_profile.poc_name).to eq('Contact')
      expect(new_profile.poc_email).to eq('contact@example.com')
      expect(new_profile.terms_of_service).to be(true)
    end
  end
end

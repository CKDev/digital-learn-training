require 'rails_helper'

describe LearnersSessionsController do
  let(:organization) { create(:organization) }
  let(:auth_code) { mock('OAuth2::Strategy::AuthCode') }
  let(:oauth_client) { mock('OAuth2::Client') }

  before do
    @request.host = "#{organization.subdomain}.dltest.org"
    DigitalLearnOauthClient.stubs(:dl_client).with(organization).returns(oauth_client)
    oauth_client.stubs(:auth_code).returns(auth_code)
  end

  describe 'GET #new' do
    it 'redirects to the learners site authorization url' do
      auth_code.stubs(:authorize_url).returns('https://learners.example.com/oauth/authorize?client_id=abc')

      get :new

      expect(response).to redirect_to('https://learners.example.com/oauth/authorize?client_id=abc')
    end
  end

  describe 'GET #callback' do
    let(:token) { mock('OAuth2::AccessToken') }
    let(:me_response) { mock('OAuth2::Response') }
    let(:user_info) do
      {
        'email' => 'learner@example.com',
        'organization_subdomain' => organization.subdomain,
        'is_org_admin' => false,
        'is_trainer' => false
      }
    end

    before do
      auth_code.stubs(:get_token).returns(token)
      token.stubs(:get).with('/api/v1/me').returns(me_response)
      me_response.stubs(:parsed).returns(user_info)
    end

    context 'when the organization does not restrict access to trainers' do
      it 'creates and signs in the user' do
        expect do
          get :callback, params: { code: 'abc123' }
        end.to change(User, :count).by(1)

        expect(controller.current_user.email).to eq('learner@example.com')
        expect(response).to redirect_to(root_path)
      end

      it 'grants the user role for the organization' do
        get :callback, params: { code: 'abc123' }

        user = User.find_by(email: 'learner@example.com')
        expect(user.has_role?(:user, organization)).to be true
      end

      it 'removes a stale trainer role when a previously-trainer person signs in as a plain user' do
        existing_user = create(:user, email: 'learner@example.com')
        existing_user.add_role(:trainer, organization)

        get :callback, params: { code: 'abc123' }

        existing_user.reload
        expect(existing_user.has_role?(:trainer, organization)).to be false
        expect(existing_user.has_role?(:user, organization)).to be true
      end
    end

    context 'when the organization is not found' do
      let(:user_info) do
        {
          'email' => 'learner@example.com',
          'organization_subdomain' => 'doesnotexist',
          'is_org_admin' => false,
          'is_trainer' => false
        }
      end

      it 'raises an OrganizationNotFoundError' do
        expect do
          get :callback, params: { code: 'abc123' }
        end.to raise_error(LearnersSessionsController::OrganizationNotFoundError)
      end
    end

    context 'when the organization restricts access to trainers only' do
      before { organization.update!(trainers_only: true) }

      context 'and the person is a plain user' do
        it 'rejects the sign-in without creating a user' do
          expect do
            get :callback, params: { code: 'abc123' }
          end.not_to change(User, :count)

          expect(controller.current_user).to be_nil
          expect(flash[:alert]).to be_present
          expect(response).to redirect_to(root_path)
        end
      end

      context 'and the person is a trainer' do
        let(:user_info) do
          {
            'email' => 'trainer@example.com',
            'organization_subdomain' => organization.subdomain,
            'is_org_admin' => false,
            'is_trainer' => true
          }
        end

        it 'signs the user in and grants the trainer role' do
          get :callback, params: { code: 'abc123' }

          expect(controller.current_user.email).to eq('trainer@example.com')

          user = User.find_by(email: 'trainer@example.com')
          expect(user.has_role?(:trainer, organization)).to be true
        end
      end

      context 'and the person is an org admin' do
        let(:user_info) do
          {
            'email' => 'admin@example.com',
            'organization_subdomain' => organization.subdomain,
            'is_org_admin' => true,
            'is_trainer' => false
          }
        end

        it 'signs the user in and grants the organization_admin role' do
          get :callback, params: { code: 'abc123' }

          user = User.find_by(email: 'admin@example.com')
          expect(user.has_role?(:organization_admin, organization)).to be true
        end
      end
    end
  end
end

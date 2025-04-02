require 'rails_helper'

RSpec.describe 'User registrations', type: :request do
  describe 'POST /users (sign up)' do
    let(:valid_user_params) do
      {
        user: {
          email: 'test@example.com',
          password: 'password123',
          password_confirmation: 'password123'
        }
      }
    end

    context 'with HTML format' do
      it 'returns 404 and does not create a user' do
        expect do
          expect do
            post '/users', params: valid_user_params
          end.to raise_error(ActionController::RoutingError)
        end.not_to change(User, :count)
      end
    end

    context 'with JSON format' do
      it 'returns 404 and does not create a user' do
        expect do
          expect do
            post '/users', params: valid_user_params, as: :json
          end.to raise_error(ActionController::RoutingError)
        end.not_to change(User, :count)
      end
    end
  end

  describe 'PATCH /users (update password)' do
    let(:user) { create(:user, password: 'oldpassword') }

    before do
      sign_in user
    end

    it "updates the user's password" do
      patch '/users', params: {
        user: {
          current_password: 'oldpassword',
          password: 'newsecurepassword',
          password_confirmation: 'newsecurepassword'
        }
      }

      expect(response).to have_http_status(:found) # Devise usually redirects on success
      follow_redirect!
      expect(response.body).to include('Your account has been updated') # Optional: customize to your flash

      # Reload and check password is updated
      user.reload
      expect(user.valid_password?('newsecurepassword')).to be true
    end
  end
end

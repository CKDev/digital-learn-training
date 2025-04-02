require 'rails_helper'

describe RegistrationsController do
  describe 'POST #create' do
    it 'does not allow sign ups' do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      expect do
        post :create, params: { user: { email: 'test@example.com', password: 'asdfasdf', password_confirmation: 'asdfasdf' } }
      end.not_to change(User, :count)
      expect(response).to have_http_status :not_found
    end
  end
end

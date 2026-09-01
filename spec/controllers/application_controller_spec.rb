require 'rails_helper'

describe ApplicationController do
  controller do
    def index
      render plain: 'ok'
    end
  end

  before do
    routes.draw { get 'index' => 'anonymous#index' }
    @request.host = "#{organization.subdomain}.dltest.org"
  end

  describe 'trainers-only organization access' do
    let(:organization) { create(:organization, settings: { trainers_only: true }) }

    context 'when no one is signed in' do
      it 'does not interfere (anonymous access is governed elsewhere)' do
        get :index

        expect(response).to have_http_status(:ok)
      end
    end

    context 'when a signed-in user has no role for the organization' do
      let(:user) { create(:user) }

      before { sign_in user }

      it 'signs the user out and redirects away, even for an already-valid session' do
        get :index

        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to be_present
        expect(controller.current_user).to be_nil
      end
    end

    context 'when a signed-in user has the trainer role for the organization' do
      let(:user) { create(:user) }

      before do
        user.add_role(:trainer, organization)
        sign_in user
      end

      it 'allows the request through' do
        get :index

        expect(response).to have_http_status(:ok)
      end
    end

    context 'when a signed-in user has the organization_admin role for the organization' do
      let(:user) { create(:user) }

      before do
        user.add_role(:organization_admin, organization)
        sign_in user
      end

      it 'allows the request through' do
        get :index

        expect(response).to have_http_status(:ok)
      end
    end

    context 'when a signed-in user is a global admin' do
      let(:user) { create(:user, admin: true) }

      before { sign_in user }

      it 'allows the request through' do
        get :index

        expect(response).to have_http_status(:ok)
      end
    end

    context 'when a signed-in user only has a role for a different organization' do
      let(:other_organization) { create(:organization, subdomain: 'other') }
      let(:user) { create(:user) }

      before do
        user.add_role(:trainer, other_organization)
        sign_in user
      end

      it 'signs the user out and redirects away' do
        get :index

        expect(response).to redirect_to(root_path)
        expect(controller.current_user).to be_nil
      end
    end
  end

  describe 'organization without the trainers-only restriction' do
    let(:organization) { create(:organization) }
    let(:user) { create(:user) }

    before { sign_in user }

    it 'allows the request through regardless of role' do
      get :index

      expect(response).to have_http_status(:ok)
    end
  end
end

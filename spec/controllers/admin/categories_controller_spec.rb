require 'rails_helper'

describe Admin::CategoriesController do
  let(:admin) { create(:admin) }

  describe 'GET #new' do
    it 'redirects to the homepage if not authenticated' do
      get :new
      expect(response).to redirect_to new_user_session_path
    end

    it 'assigns a new instance of a category' do
      sign_in admin
      get :new
      expect(assigns(:category)).to be_an_instance_of(Category)
    end
  end

  describe 'GET #index' do
    it 'redirects to the homepage if not authenticated' do
      get :index
      expect(response).to redirect_to new_user_session_path
    end

    it 'assigns all categories' do
      sign_in admin
      getting_started = create(:category)
      operating_systems = create(:category)

      get :index
      expect(assigns(:categories)).to contain_exactly(getting_started, operating_systems)
    end
  end

  describe 'POST #create' do
    let(:valid_attributes) do
      {
        title: 'New Category',
        description: 'Category description',
        tag: 'Hardware',
        sub_categories_attributes: {
          '0' => {
            title: 'Sub Category Title'
          }
        }
      }
    end

    let(:invalid_attributes) do
      {
        title: '',
        description: '',
        tag: ''
      }
    end

    it 'redirects to the homepage if not authenticated' do
      post :create, params: { category: valid_attributes }
      expect(response).to redirect_to new_user_session_path
    end

    context 'when authenticated as an admin' do
      before { sign_in admin }

      it 'correctly assigns the passed in info' do
        post :create, params: { category: valid_attributes }
        category = Category.last
        expect(category.title).to eq 'New Category'
        expect(category.description).to eq 'Category description'
        expect(category.tag).to eq 'Hardware'
        expect(category.sub_categories.first.title).to eq 'Sub Category Title'
      end

      it 'renders the new view if there is missing information' do
        post :create, params: { category: invalid_attributes }
        expect(response).to render_template :new
      end
    end
  end

  describe 'GET #edit' do
    it 'redirects to the homepage if not authenticated' do
      get :edit, params: { id: 1 }
      expect(response).to redirect_to new_user_session_path
    end

    it 'assigns the given instance of a category' do
      sign_in admin
      category = FactoryBot.create(:category)
      get :edit, params: { id: category.id }
      expect(assigns(:category)).to eq category
    end
  end

  describe 'PUT #update' do
    let(:valid_attributes) do
      {
        title: 'Updated Category',
        description: 'Updated Category description',
        tag: 'Hardware',
        sub_categories_attributes: {
          '0' => {
            title: 'Updated Sub Category Title'
          }
        }
      }
    end

    let(:invalid_attributes) do
      {
        title: '',
        description: '',
        tag: ''
      }
    end

    it 'redirects to the homepage if not authenticated' do
      put :update, params: { id: 1, category: valid_attributes }
      expect(response).to redirect_to new_user_session_path
    end

    context 'when authenticated admin' do
      before { sign_in admin }

      it 'correctly assigns the passed in info' do
        category = create(:category)
        put :update, params: { id: category.id, category: valid_attributes }
        category.reload
        expect(category.title).to eq 'Updated Category'
        expect(category.description).to eq 'Updated Category description'
        expect(category.tag).to eq 'Hardware'
        expect(category.sub_categories.first.title).to eq 'Updated Sub Category Title'
      end

      it 'renders the edit view if there is missing information' do
        category = FactoryBot.create(:category)
        put :update, params: { id: category.id, category: invalid_attributes }
        expect(response).to render_template :edit
      end
    end
  end
end

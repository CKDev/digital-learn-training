require "rails_helper"

describe Admin::CategoriesController do

  describe "GET #new" do

    it "assigns a new instance of a category" do
      @admin = FactoryGirl.create(:admin)
      sign_in @admin
      get :new
      expect(assigns(:category)).to be_an_instance_of(Category)
    end

    it "redirects to the homepage if not authenticated" do
      get :new
      expect(response).to redirect_to new_user_session_path
    end

  end

  describe "GET #index" do

    it "assigns all categorys" do
      @admin = FactoryGirl.create(:admin)
      sign_in @admin
      @category1 = FactoryGirl.create(:category)
      @category2 = FactoryGirl.create(:category)
      get :index
      expect(assigns(:categories)).to contain_exactly(@category1, @category2)
    end

    it "redirects to the homepage if not authenticated" do
      get :index
      expect(response).to redirect_to new_user_session_path
    end

  end

  describe "POST #create" do

    let(:valid_attributes) do
      {
        title: "New Category",
        description: "Category description",
        tag: "Hardware"
      }
    end

    let(:invalid_attributes) do
      {
        title: "",
        description: "",
        tag: ""
      }
    end

    it "correctly assigns the passed in info" do
      @admin = FactoryGirl.create(:admin)
      sign_in @admin
      post :create, params: { category: valid_attributes }
      category = Category.last
      expect(category.title).to eq "New Category"
      expect(category.description).to eq "Category description"
      expect(category.tag).to eq "Hardware"
      # TODO: impl subcategories
    end

    it "renders the new view if there is missing information" do
      @admin = FactoryGirl.create(:admin)
      sign_in @admin
      post :create, params: { category: invalid_attributes }
      expect(response).to render_template :new
    end

    it "redirects to the homepage if not authenticated" do
      post :create, params: { category: valid_attributes }
      expect(response).to redirect_to new_user_session_path
    end

  end

  describe "GET #edit" do

    it "assigns the given instance of a category" do
      @admin = FactoryGirl.create(:admin)
      sign_in @admin
      @category = FactoryGirl.create(:category)
      get :edit, params: { id: @category.id }
      expect(assigns(:category)).to eq @category
    end

    it "redirects to the homepage if not authenticated" do
      get :edit, params: { id: 1 }
      expect(response).to redirect_to new_user_session_path
    end

  end

  describe "PUT #update" do

    let(:valid_attributes) do
      {
        title: "Updated Category",
        description: "Updated Category description",
        tag: "Hardware"
      }
    end

    let(:invalid_attributes) do
      {
        title: "",
        description: "",
        tag: ""
      }
    end

    it "correctly assigns the passed in info" do
      @category = FactoryGirl.create(:category)
      @admin = FactoryGirl.create(:admin)
      sign_in @admin
      put :update, params: { id: @category.id, category: valid_attributes }
      @category.reload
      expect(@category.title).to eq "Updated Category"
      expect(@category.description).to eq "Updated Category description"
      expect(@category.tag).to eq "Hardware"
      # TODO: impl subcategories
    end

    it "renders the edit view if there is missing information" do
      @category = FactoryGirl.create(:category)
      @admin = FactoryGirl.create(:admin)
      sign_in @admin
      put :update, params: { id: @category.id, category: invalid_attributes }
      expect(response).to render_template :edit
    end

    it "redirects to the homepage if not authenticated" do
      put :update, params: { id: 1, category: valid_attributes }
      expect(response).to redirect_to new_user_session_path
    end

  end

end

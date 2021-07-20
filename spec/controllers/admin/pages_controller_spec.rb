require "rails_helper"

describe Admin::PagesController do

  describe "GET #new" do

    it "assigns a new instance of a page" do
      @admin = FactoryBot.create(:admin)
      sign_in @admin
      get :new
      expect(assigns(:page)).to be_an_instance_of(Page)
    end

    it "redirects to the homepage if not authenticated" do
      get :new
      expect(response).to redirect_to new_user_session_path
    end

  end

  describe "GET #index" do

    it "assigns all pages" do
      @admin = FactoryBot.create(:admin)
      sign_in @admin
      @page1 = FactoryBot.create(:page)
      @page2 = FactoryBot.create(:page)
      get :index
      expect(assigns(:pages)).to contain_exactly(@page1, @page2)
    end

    it "redirects to the homepage if not authenticated" do
      get :index
      expect(response).to redirect_to new_user_session_path
    end

  end

  describe "POST #create" do

    let(:valid_attributes) do
      {
        title: "New Page",
        body: "<p>Body</p>",
        pub_status: "P",
        author: "admin",
        seo_title: "SEO Title",
        meta_desc: "Meta Desc"
      }
    end

    let(:invalid_attributes) do
      {
        title: "",
        body: "",
        author: ""
      }
    end

    it "correctly assigns the passed in info" do
      @admin = FactoryBot.create(:admin)
      sign_in @admin
      post :create, params: { page: valid_attributes }
      page = Page.last
      expect(page.title).to eq "New Page"
      # expect(page.slug).to eq "new-page"
      expect(page.body).to eq "<p>Body</p>"
      expect(page.pub_status).to eq "P"
      expect(page.author).to eq "admin"
      expect(page.seo_title).to eq "SEO Title"
      expect(page.meta_desc).to eq "Meta Desc"
      expect(page.pub_at.present?).to be true
    end

    it "renders the new view if there is missing information" do
      @admin = FactoryBot.create(:admin)
      sign_in @admin
      post :create, params: { page: invalid_attributes }
      expect(response).to render_template :new
    end

    it "redirects to the homepage if not authenticated" do
      post :create, params: { page: valid_attributes }
      expect(response).to redirect_to new_user_session_path
    end

  end

  describe "GET #edit" do

    it "assigns the given instance of a page" do
      @admin = FactoryBot.create(:admin)
      sign_in @admin
      @page = FactoryBot.create(:page)
      get :edit, params: { id: @page.id }
      expect(assigns(:page)).to eq @page
    end

    it "redirects to the homepage if not authenticated" do
      get :edit, params: { id: 1 }
      expect(response).to redirect_to new_user_session_path
    end

  end

  describe "PUT #update" do

    let(:valid_attributes) do
      {
        title: "Updated Page",
        body: "<p>Updated Body</p>",
        pub_status: "A",
        author: "admin-2",
        seo_title: "Updated SEO Title",
        meta_desc: "Updated Meta Desc"
      }
    end

    let(:invalid_attributes) do
      {
        title: "",
        body: "",
        author: ""
      }
    end

    it "correctly assigns the passed in info" do
      @page = FactoryBot.create(:page)
      @admin = FactoryBot.create(:admin)
      sign_in @admin
      put :update, params: { id: @page.id, page: valid_attributes }
      @page.reload
      expect(@page.title).to eq "Updated Page"
      expect(@page.slug).to eq "updated-page"
      expect(@page.body).to eq "<p>Updated Body</p>"
      expect(@page.pub_status).to eq "A"
      expect(@page.author).to eq "admin-2"
      expect(@page.seo_title).to eq "Updated SEO Title"
      expect(@page.meta_desc).to eq "Updated Meta Desc"
      expect(@page.pub_at).to be nil
    end

    it "renders the edit view if there is missing information" do
      @page = FactoryBot.create(:page)
      @admin = FactoryBot.create(:admin)
      sign_in @admin
      put :update, params: { id: @page.id, page: invalid_attributes }
      expect(response).to render_template :edit
    end

    it "redirects to the homepage if not authenticated" do
      get :update, params: { id: 1, page: invalid_attributes }
      expect(response).to redirect_to new_user_session_path
    end

  end

end

require "rails_helper"

describe PagesController do

  describe "GET #show" do

    it "assigns the given instance of a page" do
      @page = FactoryBot.create(:page, pub_status: "P")
      get :show, params: { id: @page.slug }
      expect(assigns(:page)).to eq @page
    end

    it "does not assign draft/archived pages" do
      @page1 = FactoryBot.create(:page, pub_status: "D")
      @page2 = FactoryBot.create(:page, pub_status: "A")

      expect do
        get :show, params: { id: @page1.slug }
      end.to raise_error ActiveRecord::RecordNotFound

      expect do
        get :show, params: { id: @page2.slug }
      end.to raise_error ActiveRecord::RecordNotFound

    end

    it "assigns draft/archived pages, if logged in as admin" do
      @admin = FactoryBot.create(:admin)
      sign_in @admin

      @page1 = FactoryBot.create(:page, pub_status: "D")
      @page2 = FactoryBot.create(:page, pub_status: "A")

      get :show, params: { id: @page1.slug }
      expect(assigns(:page)).to eq @page1

      get :show, params: { id: @page2.slug }
      expect(assigns(:page)).to eq @page2
    end

  end

end

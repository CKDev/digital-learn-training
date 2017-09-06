require "rails_helper"

describe CategoriesController do

  context "GET #show" do
    it "should show courses, by category" do
      @category = FactoryGirl.create(:category)
      @sub_category = FactoryGirl.create(:sub_category)
      @course_material1 = FactoryGirl.create(:course_material, category: @category, pub_status: "P")
      @course_material2 = FactoryGirl.create(:course_material, category: @category, sub_category: @sub_category, pub_status: "P")
      get :show, params: { id: @category.id }
      expect(assigns(:category)).to eq @category
      expect(assigns(:course_materials)).to eq [@course_material1]
      expect(assigns(:sub_categorized_course_materials)).to eq [@course_material2]
    end
  end

end

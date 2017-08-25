require "rails_helper"

describe CourseMaterialsController do

  describe "GET #show" do

    it "assigns the last 3 courses in the same category, that are published, and not self" do
      @category1 = FactoryGirl.create(:category2)
      @category2 = FactoryGirl.create(:category2)
      @course_material1 = FactoryGirl.create(:course_material, pub_status: "P", category: @category1)
      @course_material2 = FactoryGirl.create(:course_material, pub_status: "P", category: @category1)
      @course_material3 = FactoryGirl.create(:course_material, pub_status: "P", category: @category1)
      @course_material4 = FactoryGirl.create(:course_material, pub_status: "P", category: @category1)
      @course_material5 = FactoryGirl.create(:course_material, pub_status: "P", category: @category2)
      @course_material5 = FactoryGirl.create(:course_material, pub_status: "D", category: @category1)
      get :show, params: { id: @course_material1.id }
      expect(assigns(:course_materials)).to contain_exactly(@course_material2, @course_material3, @course_material4)
    end

  end

end

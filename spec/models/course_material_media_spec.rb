require "rails_helper"

describe CourseMaterialMedia do

  context "validations" do

    before :each do
      @course_material_media = FactoryBot.create(:course_material_media)
    end

    it "should initially be valid" do
      expect(@course_material_media.valid?).to be true
    end

  end

end

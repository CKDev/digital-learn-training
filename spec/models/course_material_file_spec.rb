require "rails_helper"

describe CourseMaterialFile do

  context "validations" do

    before :each do
      @course_material_file = FactoryBot.create(:course_material_file)
    end

    it "should initially be valid" do
      expect(@course_material_file.valid?).to be true
    end

  end

end

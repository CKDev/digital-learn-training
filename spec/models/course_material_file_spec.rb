require "rails_helper"

describe CourseMaterialFile do

  context "validations" do

    before do
      @course_material_file = FactoryBot.create(:course_material_file)
    end

    it "initiallies be valid" do
      expect(@course_material_file.valid?).to be true
    end

  end

end

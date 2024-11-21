require "rails_helper"

describe CourseMaterialMedia do

  context "validations" do

    before do
      @course_material_media = FactoryBot.create(:course_material_media)
    end

    it "initiallies be valid" do
      expect(@course_material_media.valid?).to be true
    end

  end

end

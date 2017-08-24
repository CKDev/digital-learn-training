require "rails_helper"

describe CourseMaterialVideo do

  before :each do
    @course_material_video = FactoryGirl.create(:course_material_video)
  end

  context "validations" do

    it "should initially be valid" do
      expect(@course_material_video.valid?).to be true
    end

    it "should require the url" do
      @course_material_video.update(url: "")
      expect(@course_material_video.valid?).to be false
    end

    it "should only allow valid formatted urls" do
      @course_material_video = FactoryGirl.build(:course_material_video)

      @course_material_video.update(url: "something")
      expect(@course_material_video.valid?).to be false

      @course_material_video.update(url: "http://")
      expect(@course_material_video.valid?).to be false

      @course_material_video.update(url: "http://google.com")
      expect(@course_material_video.valid?).to be false

      @course_material_video.update(url: "")
      expect(@course_material_video.valid?).to be false

      @course_material_video.update(url: nil)
      expect(@course_material_video.valid?).to be false

      @course_material_video.update(url: "ftp://something.com")
      expect(@course_material_video.valid?).to be false

      @course_material_video.update(url: "@")
      expect(@course_material_video.valid?).to be false

      @course_material_video.update(url: "https://youtu.be/oW2aeEQRrK0")
      expect(@course_material_video.valid?).to be true
    end

  end

end

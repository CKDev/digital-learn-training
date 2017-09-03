require "rails_helper"

describe Course do

  before :each do
    @course = FactoryGirl.create(:course)
  end

  context "validations" do

    it "is initially valid" do
      expect(@course.valid?).to be true
    end

    it "should require the title to be unique" do
      @course2 = FactoryGirl.build(:course, title: @course.title)
      expect(@course2.valid?).to be false
    end

  end

end

require "rails_helper"

describe Course do

  before :each do
    @course = FactoryGirl.create(:course)
  end

  context "validations" do

    it "is initially valid" do
      expect(@course.valid?).to be true
    end

    pending "it should require the title to be unique"

  end

end

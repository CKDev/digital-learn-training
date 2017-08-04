require "rails_helper"

describe Lesson do

  before :each do
    @course = FactoryGirl.create(:course)
    @lesson = FactoryGirl.create(:lesson, course: @course)
  end

  context "validations" do

    it "is initially valid" do
      expect(@lesson.valid?).to be true
    end

  end

end

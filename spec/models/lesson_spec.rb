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

    it "requires the title to be unique for a given course" do
      @lesson2 = FactoryGirl.build(:lesson, course: @course, title: @lesson.title)
      expect(@lesson2.valid?).to be false
    end

  end

  context "#duration_str" do

    it "should add up the durations of all lessons" do
      @course = FactoryGirl.create(:course_with_lessons)
      expect(@course.lessons.first.duration_str).to eq "01:30"
    end

  end

end

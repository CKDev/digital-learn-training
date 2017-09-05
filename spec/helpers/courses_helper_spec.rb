require "rails_helper"

describe CoursesHelper do

  context ".percent_complete" do

    it "should give the correct percentage of courses that have been finished" do
      @course1 = FactoryGirl.create(:course_with_lessons)
      expect(helper.percent_complete(@course1, nil)).to eq 0
    end

    it "should give the correct percentage of courses that have been finished" do
      @course1 = FactoryGirl.create(:course_with_lessons)
      expect(helper.percent_complete(@course1, @course1.lessons.first.id)).to eq 33
    end

    it "should properly handle when there are multiple courses" do
      @course1 = FactoryGirl.create(:course_with_lessons)
      @course2 = FactoryGirl.create(:course_with_lessons)
      @course1.lessons.each do |l|
        helper.percent_complete(@course1, l)
      end

      expect(helper.percent_complete(@course2, @course2.lessons.first.id)).to eq 33
    end

  end

end

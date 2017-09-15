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

  context "scopes" do

    context ".published" do

      it "returns all published lessons" do
        @course = FactoryGirl.create(:course_with_lessons)
        expect(@course.lessons.published).to contain_exactly(@course.lessons.first, @course.lessons.second, @course.lessons.third)
      end

      it "returns all published lessons" do
        @course = FactoryGirl.create(:course_with_lessons)
        @course.lessons.second.update(pub_status: "D")
        expect(@course.lessons.published).to contain_exactly(@course.lessons.first, @course.lessons.third)
      end

      it "returns all published lessons" do
        @course = FactoryGirl.create(:course_with_lessons)
        @course.lessons.second.update(pub_status: "A")
        expect(@course.lessons.published).to contain_exactly(@course.lessons.first, @course.lessons.third)
      end

    end

  end

  context "#duration_str" do

    it "should add up the durations of all lessons" do
      @course = FactoryGirl.create(:course_with_lessons)
      expect(@course.lessons.first.duration_str).to eq "01:30"
    end

  end

  context "#published_lesson_order" do

    it "returns the order of only published lessons" do
      @course = FactoryGirl.create(:course_with_lessons)
      @course.lessons.second.update(pub_status: "D")
      expect(@course.lessons.first.published_lesson_order).to eq 1
      expect(@course.lessons.second.published_lesson_order).to eq 0
      expect(@course.lessons.third.published_lesson_order).to eq 2
    end

  end

end

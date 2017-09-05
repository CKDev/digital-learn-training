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

  context "#next_lesson_id" do

    it "should raise an error if there are no lessons" do
      expect do
        @course = FactoryGirl.create(:course)
        @course.next_lesson_id(@course.lessons.first.id)
      end.to raise_error StandardError
    end

    it "should return the id of the next lesson in order" do
      @course = FactoryGirl.create(:course_with_lessons)
      expect(@course.next_lesson_id).to eq @course.lessons.first.id
      expect(@course.next_lesson_id(nil)).to eq @course.lessons.first.id
      expect(@course.next_lesson_id(@course.lessons.first.id)).to eq @course.lessons.second.id
      expect(@course.next_lesson_id(@course.lessons.second.id)).to eq @course.lessons.third.id
      expect(@course.next_lesson_id(@course.lessons.third.id)).to eq @course.lessons.third.id
    end

    it "should return the next lesson id, even if the lessons are out of order" do
      @course = FactoryGirl.create(:course_with_lessons)
      @course.lessons.third.update(lesson_order: 5)
      expect(@course.next_lesson_id(@course.lessons.first.id)).to eq @course.lessons.second.id
      expect(@course.next_lesson_id(@course.lessons.second.id)).to eq @course.lessons.third.id
      expect(@course.next_lesson_id(@course.lessons.third.id)).to eq @course.lessons.third.id
    end

    it "should skip unpublished lessons" do
      @course = FactoryGirl.create(:course_with_lessons)
      @course.lessons.second.update(pub_status: "D")
      @course.lessons.third.update(lesson_order: 5)
      expect(@course.next_lesson_id(@course.lessons.first.id)).to eq @course.lessons.third.id
      expect(@course.next_lesson_id(@course.lessons.third.id)).to eq @course.lessons.third.id
    end

  end

end

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

  context "#duration" do

    it "should add up the durations of all lessons" do
      @course = FactoryGirl.create(:course_with_lessons)
      expect(@course.duration).to eq "4 mins" # 90 * 3 = 270 / 60 = 4.5 mins
    end

    it "should not count draft lessons" do
      @course = FactoryGirl.create(:course_with_lessons)
      @course.lessons.first.update(pub_status: "D")
      expect(@course.duration).to eq "3 mins" # 90 * 2 = 180 / 60 = 3 mins
    end

  end

  context "#pub_date_str" do

    it "print the published date in a nice format" do
      Timecop.freeze(Time.zone.local(2017, 9, 1, 12, 0, 0)) do
        @course = FactoryGirl.create(:course)
        expect(@course.pub_date_str).to eq "09/01/2017"
      end
    end

    it "should print N/A if the course isn't published" do
      @course = FactoryGirl.create(:course, pub_status: "D")
      expect(@course.pub_date_str).to eq "N/A"
    end

  end

end

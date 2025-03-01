require 'rails_helper'

describe Lesson do
  describe 'validations' do
    let(:course) { create(:course) }
    let(:lesson) { create(:lesson, course: course) }

    it 'is valid' do
      expect(lesson.valid?).to be true
    end

    it 'requires the title to be unique for a given course' do
      duplicate_title_lesson = FactoryBot.build(:lesson, course: course, title: lesson.title)
      expect(duplicate_title_lesson).not_to be_valid
    end

    it 'allows duplicate title for another course' do
      new_course = create(:course)
      new_course_lesson = FactoryBot.build(:lesson, course: new_course, title: lesson.title)
      expect(new_course_lesson).to be_valid
      expect(new_course_lesson.save).to be true
    end

    it 'requires valid pub status' do
      lesson.pub_status = 'F'
      expect(lesson).not_to be_valid
      expect(lesson.errors.full_messages).to contain_exactly('Publication Status "F" is not a valid status')
    end
  end

  describe 'scopes' do
    let(:course) { create(:course, :with_lessons) }

    describe '.published' do
      it 'returns all published lessons' do
        expect(course.lessons.published).to contain_exactly(course.lessons.first, course.lessons.second, course.lessons.third)
      end

      it 'does not return draft lessons' do
        course.lessons.second.update(pub_status: 'D')
        expect(course.lessons.published).to contain_exactly(course.lessons.first, course.lessons.third)
      end

      it 'does not return archived lessons' do
        course.lessons.second.update(pub_status: 'A')
        expect(course.lessons.published).to contain_exactly(course.lessons.first, course.lessons.third)
      end
    end
  end

  describe '#duration_str' do
    let(:course) { create(:course, :with_lessons) }

    it 'adds up the durations of all lessons' do
      expect(course.lessons.first.duration_str).to eq '01:30'
    end
  end

  describe '#published_lesson_order' do
    let(:course) { create(:course, :with_lessons) }

    it 'returns the order of only published lessons' do
      course.lessons.second.update(pub_status: 'D')
      expect(course.lessons.first.published_lesson_order).to eq 1
      expect(course.lessons.second.published_lesson_order).to eq 0
      expect(course.lessons.third.published_lesson_order).to eq 2
    end
  end
end

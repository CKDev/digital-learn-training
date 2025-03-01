require 'rails_helper'

describe Course do
  let(:course) { create(:course) }

  describe 'validations' do
    it 'is valid' do
      expect(course.valid?).to be true
    end

    it 'requires the title to be unique' do
      duplicate_title_course = FactoryBot.build(:course, title: course.title)
      expect(duplicate_title_course.valid?).to be false
    end

    it 'requires valid pub status' do
      course.pub_status = 'F'
      expect(course).not_to be_valid
      expect(course.errors.full_messages).to contain_exactly('Publication Status "F" is not a valid status')
    end
  end

  describe '#next_lesson_id' do
    context 'when course has no lessons' do
      let(:course) { create(:course) }

      it 'raises an error' do
        expect do
          course.next_lesson_id(course.lessons.first.id)
        end.to raise_error StandardError
      end
    end

    context 'when course has lessons' do
      let(:course) { create(:course, :with_lessons) }

      it 'returns the id of the next lesson in order' do
        expect(course.next_lesson_id).to eq course.lessons.first.id
        expect(course.next_lesson_id(nil)).to eq course.lessons.first.id
        expect(course.next_lesson_id(course.lessons.first.id)).to eq course.lessons.second.id
        expect(course.next_lesson_id(course.lessons.second.id)).to eq course.lessons.third.id
        expect(course.next_lesson_id(course.lessons.third.id)).to eq course.lessons.third.id
      end

      it 'returns the next lesson id, even if the lessons are out of order' do
        course.lessons.third.update(lesson_order: 5)
        expect(course.next_lesson_id(course.lessons.first.id)).to eq course.lessons.second.id
        expect(course.next_lesson_id(course.lessons.second.id)).to eq course.lessons.third.id
        expect(course.next_lesson_id(course.lessons.third.id)).to eq course.lessons.third.id
      end

      it 'skips unpublished lessons' do
        course.lessons.second.update(pub_status: 'D')
        course.lessons.third.update(lesson_order: 5)
        expect(course.next_lesson_id(course.lessons.first.id)).to eq course.lessons.third.id
        expect(course.next_lesson_id(course.lessons.third.id)).to eq course.lessons.third.id
      end
    end
  end

  describe '#duration' do
    let(:course) { create(:course, :with_lessons) }

    it 'adds up the durations of all lessons' do
      expect(course.duration).to eq '4 mins' # 90 * 3 = 270 / 60 = 4.5 mins
    end

    it 'does not count draft lessons' do
      course.lessons.first.update(pub_status: 'D')
      expect(course.duration).to eq '3 mins' # 90 * 2 = 180 / 60 = 3 mins
    end
  end

  describe '#update_pub_date' do
    let(:course) { create(:course, pub_status: 'D') }

    it 'sets the pub_date to the current timestamp the pub_status is now P' do
      expect(course.pub_date).to be_nil
      course.update(pub_status: 'P')
      expect(course.pub_date.present?).to be true
    end

    it 'sets the pub_date nil if the course is no longer published' do
      course.update!(pub_status: 'P', pub_date: Time.zone.now)
      expect(course.pub_date.present?).to be true
      course.update(pub_status: 'A')
      expect(course.pub_date).to be_nil
    end
  end

  describe '#pub_date_str' do
    it 'print the published date in a nice format' do
      Timecop.freeze(Time.zone.local(2017, 9, 1, 12, 0, 0)) do
        course = create(:course)
        expect(course.pub_date_str).to eq '09/01/2017'
      end
    end

    it "prints N/A if the course isn't published" do
      course = create(:course, pub_status: 'D')
      expect(course.pub_date_str).to eq 'N/A'
    end
  end
end

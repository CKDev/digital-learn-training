require 'rails_helper'

describe CourseMaterialMedia do
  describe 'validations' do
    let(:course_material_media) { create(:course_material_media) }

    it 'is valid' do
      expect(course_material_media.valid?).to be true
    end

    it 'is invalid with a duplicate filename in the same course material' do
      duplicate_filename_media = FactoryBot.build(:course_material_media, course_material: course_material_media.course_material)
      expect(duplicate_filename_media).not_to be_valid
      expect(duplicate_filename_media.errors.full_messages).to contain_exactly('Media file name should be unique for the course')
    end

    it 'is valid with a duplicate filename for a different course material' do
      other_material_media = FactoryBot.build(:course_material_media)
      expect(other_material_media).to be_valid
      expect(other_material_media.save).to be true
    end
  end
end

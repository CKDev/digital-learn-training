require 'rails_helper'

describe CourseMaterialVideo do

  before do
    @course_material_video = create(:course_material_video)
  end

  context 'validations' do

    it 'initiallies be valid' do
      expect(@course_material_video.valid?).to be true
    end

    it 'requires the url' do
      @course_material_video.update(url: '')
      expect(@course_material_video.valid?).to be false
    end

    it 'onlies allow valid formatted urls' do
      @course_material_video = FactoryBot.build(:course_material_video)

      @course_material_video.update(url: 'something')
      expect(@course_material_video.valid?).to be false

      @course_material_video.update(url: 'http://')
      expect(@course_material_video.valid?).to be false

      @course_material_video.update(url: 'http://google.com')
      expect(@course_material_video.valid?).to be false

      @course_material_video.update(url: '')
      expect(@course_material_video.valid?).to be false

      @course_material_video.update(url: nil)
      expect(@course_material_video.valid?).to be false

      @course_material_video.update(url: 'ftp://something.com')
      expect(@course_material_video.valid?).to be false

      @course_material_video.update(url: '@')
      expect(@course_material_video.valid?).to be false

      @course_material_video.update(url: 'https://youtu.be/oW2aeEQRrK0')
      expect(@course_material_video.valid?).to be true
    end

  end

end

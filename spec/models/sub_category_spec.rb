require 'rails_helper'

describe Category do
  context 'validations' do

    before do
      @category = FactoryBot.create(:sub_category)
    end

    it 'initiallies be valid' do
      expect(@category.valid?).to be true
    end

    it 'requires a title' do
      @category.update(title: '')
      expect(@category.valid?).to be false
    end

  end

end

require 'rails_helper'

describe Category do
  describe 'validations' do
    let(:category) { create(:category) }

    it 'is valid' do
      expect(category.valid?).to be true
    end

    it 'requires a title' do
      category.update(title: '')
      expect(category.valid?).to be false
    end

    it 'requires a tag' do
      category.update(tag: '')
      expect(category.valid?).to be false
    end

    it 'requires the tag to be in the known list' do
      category.update(tag: 'something else')
      expect(category.valid?).to be false
    end

    it 'returns correct error message for invalid tag' do
      category.update(tag: 'something else')
      category.valid?
      expect(category.errors.full_messages).to contain_exactly('Tag "something else" is not a valid category tag')
    end
  end

  describe '.select_options' do
    it 'pull out the other category from the select options' do
      expect(described_class.select_options.include?('Other')).to be false
    end
  end

  describe '#to_props' do
    let(:category) { create(:category) }

    it 'includes correct props' do
      expected_props = {
        id: category.id,
        friendlyId: category.friendly_id,
        title: category.title,
        tag: category.tag,
        description: category.description,
        subcategories: [],
        organization: nil
      }
      expect(category.to_props).to eq(expected_props)
    end

    it 'includes published course materials when specified' do
      create(:course_material, category: category, title: 'Published CM', pub_status: 'P')
      create(:course_material, category: category, title: 'Archived CM', pub_status: 'A')
      create(:course_material, category: category, title: 'Draft CM', pub_status: 'D')

      props = category.reload.to_props(include_materials: true)
      expect(props[:courseMaterials].count).to eq(1)
      expect(props[:courseMaterials].pluck(:title)).to contain_exactly('Published CM')
    end
  end
end

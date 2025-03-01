require 'rails_helper'

describe Constants do

  it 'has a method that defines the allowed attachment types' do
    expect(described_class.course_material_file_types.present?).to be true
  end

  it 'has a method for displaying course material file types' do
    expect(described_class.course_material_file_types_str.present?).to be true
  end

  it 'defines valid attachment content types' do
    expect(described_class.attachment_content_types.present?).to be true
  end

  it 'has a method for displaying valid attachment content types' do
    expect(described_class.attachment_content_types_str.present?).to be true
  end

  it 'defines valid course material media types' do
    expect(described_class.course_material_media_types.present?).to be true
  end

  it 'has a method for displaying valid course material media content types' do
    expect(described_class.course_material_media_types_str.present?).to be true
  end

  it 'returns pub status options' do
    expected_options = [['Draft', 'D'], ['Published', 'P'], ['Archived', 'A']]
    expect(described_class.pub_status_select_options).to eq(expected_options)
  end
end

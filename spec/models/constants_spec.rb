require "rails_helper"

describe Constants do

  it "should have a method that defines the allowed attachment types" do
    expect(Constants.course_material_file_types.present?).to be true
  end

  it "should have a method for displaying course material file types" do
    expect(Constants.course_material_file_types_str.present?).to be true
  end

  it "should define valid attachment content types" do
    expect(Constants.attachment_content_types.present?).to be true
  end

  it "should have a method for displaying valid attachment content types" do
    expect(Constants.attachment_content_types_str.present?).to be true
  end

  it "should define valid course material media types" do
    expect(Constants.course_material_media_types.present?).to be true
  end

  it "should have a method for displaying valid course material media content types" do
    expect(Constants.course_material_media_types_str.present?).to be true
  end

  it "should return pub status options" do
    expected_options = [["Draft", "D"], ["Published", "P"], ["Archived", "A"]]
    expect(Constants.pub_status_select_options).to eq(expected_options)
  end
end

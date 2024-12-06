require "rails_helper"

describe Category do
  describe "validations" do
    let(:category) { FactoryBot.create(:category) }

    it "is valid" do
      expect(category.valid?).to be true
    end

    it "requires a title" do
      category.update(title: "")
      expect(category.valid?).to be false
    end

    it "requires a tag" do
      category.update(tag: "")
      expect(category.valid?).to be false
    end

    it "requires the tag to be in the known list" do
      category.update(tag: "something else")
      expect(category.valid?).to be false
    end

    it "returns correct error message for invalid tag" do
      category.update(tag: "something else")
      category.valid?
      expect(category.errors.full_messages).to contain_exactly("Tag \"something else\" is not a valid category tag")
    end
  end

  describe ".select_options" do
    it "pull out the other category from the select options" do
      expect(described_class.select_options.include?("Other")).to be false
    end
  end

end

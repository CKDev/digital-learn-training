require "rails_helper"

describe Category do
  context "validations" do

    before :each do
      @category = FactoryBot.create(:category)
    end

    it "should initially be valid" do
      expect(@category.valid?).to be true
    end

    it "should require a title" do
      @category.update(title: "")
      expect(@category.valid?).to be false
    end

    it "should require a tag" do
      @category.update(tag: "")
      expect(@category.valid?).to be false
    end

    it "should require the tag to be in the known list" do
      @category.update(tag: "something else")
      expect(@category.valid?).to be false
    end
  end

  context ".select_options" do
    it "pull out the other category from the select options" do
      expect(Category.select_options.include?("Other")).to be false
    end
  end

end

require "rails_helper"

describe Category do
  context "validations" do

    before :each do
      @category = FactoryGirl.create(:category)
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

end

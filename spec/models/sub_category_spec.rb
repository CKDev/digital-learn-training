require "rails_helper"

describe Category do
  context "validations" do

    before :each do
      @category = FactoryBot.create(:sub_category)
    end

    it "should initially be valid" do
      expect(@category.valid?).to be true
    end

    it "should require a title" do
      @category.update(title: "")
      expect(@category.valid?).to be false
    end

  end

end

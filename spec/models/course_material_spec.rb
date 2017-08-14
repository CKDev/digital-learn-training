require "rails_helper"

describe CourseMaterial do

  context "validations" do

    before :each do
      @course_material = FactoryGirl.create(:course_material)
    end

    it "should initially be valid" do
      expect(@course_material.valid?).to be true
    end

    it "should require a title" do
      @course_material.update(title: "")
      expect(@course_material.valid?).to be false
    end

    it "should require the title to be unique" do
      @course_material2 = FactoryGirl.create(:course_material, title: "A New Page")
      @course_material.update(title: "A New Page")
      expect(@course_material.valid?).to be false
    end

    it "should not allow the title to be more than 90 chars" do
      title = ""
      90.times { title << "a" }
      @course_material.update(title: title)
      expect(@course_material.valid?).to be true

      @course_material.update(title: title + "a")
      expect(@course_material.valid?).to be false
    end

    it "should require a contributor" do
      @course_material.update(contributor: "")
      expect(@course_material.valid?).to be false
    end

    it "should require the contributor" do
      @course_material.update(contributor: "")
      expect(@course_material.valid?).to be false
    end

    it "should not allow the contributor to be more than 156 chars" do
      contributor = ""
      156.times { contributor << "a" }
      @course_material.update(contributor: contributor)
      expect(@course_material.valid?).to be true

      @course_material.update(contributor: contributor + "a")
      expect(@course_material.valid?).to be false
    end

    it "should not allow the summary to be more than 156 chars" do
      summary = ""
      156.times { summary << "a" }
      @course_material.update(summary: summary)
      expect(@course_material.valid?).to be true

      @course_material.update(summary: summary + "a")
      expect(@course_material.valid?).to be false
    end

  end

end

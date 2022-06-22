require "rails_helper"

describe CourseMaterial do

  context "validations" do

    before :each do
      @course_material = FactoryBot.create(:course_material)
    end

    it "should initially be valid" do
      expect(@course_material.valid?).to be true
    end

    it "should require a title" do
      @course_material.update(title: "")
      expect(@course_material.valid?).to be false
    end

    it "should require a pub_status" do
      @course_material.update(pub_status: "")
      expect(@course_material.valid?).to be false
    end

    it "should require the pub_status be in a specific list" do
      @course_material.update(pub_status: "X")
      expect(@course_material.valid?).to be false
    end

    it "should require the title to be unique" do
      @course_material2 = FactoryBot.create(:course_material, title: "A New Page")
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
      74.times { summary << "a" }
      @course_material.update(summary: summary)
      expect(@course_material.valid?).to be true

      @course_material.update(summary: summary + "a")
      expect(@course_material.valid?).to be false
    end

    it "should require the sort_order" do
      @course_material.update(sort_order: "")
      expect(@course_material.valid?).to be false
    end

    it "should require the sort_order to be greater than 0" do
      @course_material.update(sort_order: 0)
      expect(@course_material.valid?).to be false
    end

  end

  context "scopes" do

    context "default scope" do

      it "should return course_materials in sort_order order" do
        @course_material1 = FactoryBot.create(:course_material, sort_order: 3)
        @course_material2 = FactoryBot.create(:course_material, sort_order: 1)
        @course_material3 = FactoryBot.create(:course_material, sort_order: 2)
        expect(CourseMaterial.all).to eq [@course_material2, @course_material3, @course_material1]
      end

    end

    context ".archived" do

      it "should return all course_materials that are archived" do
        @course_material1 = FactoryBot.create(:course_material, pub_status: "D")
        @course_material2 = FactoryBot.create(:course_material, pub_status: "P")
        @course_material3 = FactoryBot.create(:course_material, pub_status: "A")
        expect(CourseMaterial.archived).to contain_exactly(@course_material3)
      end

    end

    context ".not_archived" do

      it "should return all course_materials that are not archived" do
        @course_material1 = FactoryBot.create(:course_material, pub_status: "D")
        @course_material2 = FactoryBot.create(:course_material, pub_status: "P")
        @course_material3 = FactoryBot.create(:course_material, pub_status: "A")
        expect(CourseMaterial.not_archived).to contain_exactly(@course_material1, @course_material2)
      end

    end

  end

end

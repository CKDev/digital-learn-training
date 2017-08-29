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

    it "should require a pub_status" do
      @course_material.update(pub_status: "")
      expect(@course_material.valid?).to be false
    end

    it "should require the pub_status be in a specific list" do
      @course_material.update(pub_status: "X")
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

    it "shouldn't allow two file attachments to have the same file name" do
      @course_material_file1 = FactoryGirl.create(:course_material_file, course_material: @course_material)
      expect(@course_material.valid?).to be true

      expect do
        @course_material_file2 = FactoryGirl.create(:course_material_file, course_material: @course_material)
      end.to raise_error ActiveRecord::RecordInvalid
    end

    it "shouldn't allow two media attachments to have the same file name" do
      @course_material_media1 = FactoryGirl.create(:course_material_media, course_material: @course_material)
      expect(@course_material.valid?).to be true

      expect do
        @course_material_media2 = FactoryGirl.create(:course_material_media, course_material: @course_material)
      end.to raise_error ActiveRecord::RecordInvalid
    end

  end

  context "scopes" do

    context ".archived" do

      it "should return all course_materials that are archived" do
        @course_material1 = FactoryGirl.create(:course_material, pub_status: "D")
        @course_material2 = FactoryGirl.create(:course_material, pub_status: "P")
        @course_material3 = FactoryGirl.create(:course_material, pub_status: "A")
        expect(CourseMaterial.archived).to contain_exactly(@course_material3)
      end

    end

    context ".not_archived" do

      it "should return all course_materials that are not archived" do
        @course_material1 = FactoryGirl.create(:course_material, pub_status: "D")
        @course_material2 = FactoryGirl.create(:course_material, pub_status: "P")
        @course_material3 = FactoryGirl.create(:course_material, pub_status: "A")
        expect(CourseMaterial.not_archived).to contain_exactly(@course_material1, @course_material2)
      end

    end

  end

end

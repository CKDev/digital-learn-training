require "rails_helper"

describe Page do

  context "validations" do

    before :each do
      @page = FactoryGirl.create(:page)
    end

    it "should initially be valid" do
      expect(@page.valid?).to be true
    end

    it "should require a title" do
      @page.update(title: "")
      expect(@page.valid?).to be false
    end

    it "should require the title to be unique" do
      @page2 = FactoryGirl.create(:page, title: "A New Page")
      @page.update(title: "A New Page")
      expect(@page.valid?).to be false
    end

    it "should not allow the title to be more than 90 chars" do
      title = ""
      90.times { title << "a" }
      @page.update(title: title)
      expect(@page.valid?).to be true

      @page.update(title: title + "a")
      expect(@page.valid?).to be false
    end

    it "should require a body" do
      @page.update(title: "")
      expect(@page.valid?).to be false
    end

    it "should initially be in draft status" do
      expect(@page.pub_status).to eq "draft"
    end

    it "should require an author" do
      @page.update(author: "")
      expect(@page.valid?).to be false
    end

    it "should not allow the author to be more than 20 chars" do
      author = ""
      20.times { author << "a" }
      @page.update(author: author)
      expect(@page.valid?).to be true

      @page.update(author: author + "a")
      expect(@page.valid?).to be false
    end

    it "should not allow the seo_title to be more than 90 chars" do
      seo_title = ""
      90.times { seo_title << "a" }
      @page.update(seo_title: seo_title)
      expect(@page.valid?).to be true

      @page.update(seo_title: seo_title + "a")
      expect(@page.valid?).to be false
    end

    it "should not allow the meta_desc to be more than 156 chars" do
      meta_desc = ""
      156.times { meta_desc << "a" }
      @page.update(meta_desc: meta_desc)
      expect(@page.valid?).to be true

      @page.update(meta_desc: meta_desc + "a")
      expect(@page.valid?).to be false
    end

  end

end

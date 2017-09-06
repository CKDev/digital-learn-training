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
      @page.update(body: "")
      expect(@page.valid?).to be false
    end

    it "should require a pub_status" do
      @page.update(pub_status: "")
      expect(@page.valid?).to be false
    end

    it "should not allow pub_status to be anything but D P A" do
      @page.update(pub_status: "X")
      expect(@page.valid?).to be false
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

  context "#update_pub_at" do

    it "should set the pub_date to the current timestamp the pub_status is now P" do
      @page = FactoryGirl.create(:page, pub_status: "D")
      expect(@page.pub_at).to be nil
      @page.update(pub_status: "P")
      expect(@page.pub_at.present?).to be true
    end

    it "should set the pub_date nil if the page is no longer published" do
      @page = FactoryGirl.create(:page, pub_status: "P", pub_at: Time.zone.now)
      expect(@page.pub_at.present?).to be true
      @page.update(pub_status: "A")
      expect(@page.pub_at).to be nil
    end
  end

end

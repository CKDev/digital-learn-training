require "rails_helper"

describe Organization do
  describe "validations" do
    let(:subject) { Organization.new }

    it "requires a title" do
      expect(subject).not_to be_valid
      expect(subject.errors.full_messages).to include("Title can't be blank")
    end

    it "allows multiple access_request_emails" do
      subject.access_request_emails = ["test1@example.com", "test2@example.com"]
      expect(subject.access_request_emails).to contain_exactly("test1@example.com", "test2@example.com")
    end
  end
end

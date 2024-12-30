require "rails_helper"

describe Organization do
  describe "validations" do
    let(:organization) { described_class.new }

    it "requires a title" do
      expect(organization).not_to be_valid
      expect(organization.errors.full_messages).to include("Title can't be blank")
    end

    it "allows multiple access_request_emails" do
      organization.access_request_emails = ["test1@example.com", "test2@example.com"]
      expect(organization.access_request_emails).to contain_exactly("test1@example.com", "test2@example.com")
    end
  end
end

require "rails_helper"

describe SubdomainBuilder do
  let(:organization) { FactoryBot.build(:att) }

  context "test/dev environment" do
    subject { described_class.new(organization) }

    it "returns expected subdomain" do
      expect(subject.build_subdomain).to eq("att")
    end
  end

  context "staging" do
    subject { described_class.new(organization, "staging") }

    it "returns expected subdomain" do
      expect(subject.build_subdomain).to eq("staging.training.att")
    end
  end

  context "production" do
    subject { described_class.new(organization, "production") }

    it "returns expected subdomain" do
      expect(subject.build_subdomain).to eq("training.att")
    end
  end
end

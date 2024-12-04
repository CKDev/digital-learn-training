require "rails_helper"

describe SubdomainBuilder do
  let(:organization) { FactoryBot.build(:att) }

  context "with an organization" do
    context "when in test or dev environment" do
      let(:builder) { described_class.new(organization) }

      it "returns expected subdomain for the trainers site" do
        expect(builder.build_subdomain).to eq("att")
      end

      it "returns expected subdomain for learners site" do
        expect(builder.build_learners_subdomain).to eq("att")
      end
    end

    context "when in staging" do
      let(:builder) { described_class.new(organization, "staging") }

      it "returns expected subdomain for trainers site" do
        expect(builder.build_subdomain).to eq("staging.training.att")
      end

      it "returns expected subdomain for learners site" do
        expect(builder.build_learners_subdomain).to eq("att.staging")
      end
    end

    context "when in production" do
      let(:builder) { described_class.new(organization, "production") }

      it "returns expected subdomain for trainers site" do
        expect(builder.build_subdomain).to eq("training.att")
      end

      it "returns expected subdomain for learners site" do
        expect(builder.build_learners_subdomain).to eq("att")
      end
    end
  end

  context "without an organization" do
    context "when in test or dev environment" do
      let(:builder) { described_class.new(nil) }

      it "returns expected subdomain for the trainers site" do
        expect(builder.build_subdomain).to eq("")
      end

      it "returns expected subdomain for learners site" do
        expect(builder.build_learners_subdomain).to eq("www")
      end
    end

    context "when in staging" do
      let(:builder) { described_class.new(nil, "staging") }

      it "returns expected subdomain for trainers site" do
        expect(builder.build_subdomain).to eq("staging.training")
      end

      it "returns expected subdomain for learners site" do
        expect(builder.build_learners_subdomain).to eq("www.staging")
      end
    end

    context "when in production" do
      let(:builder) { described_class.new(nil, "production") }

      it "returns expected subdomain for trainers site" do
        expect(builder.build_subdomain).to eq("training")
      end

      it "returns expected subdomain for learners site" do
        expect(builder.build_learners_subdomain).to eq("www")
      end
    end
  end
end

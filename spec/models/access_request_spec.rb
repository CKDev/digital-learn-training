require 'rails_helper'

describe AccessRequest do
  context 'validations' do
    let(:access_request) { FactoryBot.build(:access_request) }

    it 'is valid' do
      expect(access_request).to be_valid
    end

    it 'requires full name' do
      access_request.full_name = nil
      expect(access_request).not_to be_valid
    end

    it 'requires organization name' do
      access_request.organization_name = nil
      expect(access_request).not_to be_valid
    end

    it 'requires email' do
      access_request.email = nil
      expect(access_request).not_to be_valid
    end

    it 'requires phone' do
      access_request.phone = nil
      expect(access_request).not_to be_valid
    end

    it 'requires request_reason' do
      access_request.request_reason = nil
      expect(access_request).not_to be_valid
    end
  end
end

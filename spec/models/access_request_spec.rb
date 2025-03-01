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
      expect(access_request.errors.full_messages).to contain_exactly("Phone number can't be blank")
    end

    it 'require 10 digit phone' do
      access_request.phone = '123123'
      expect(access_request).not_to be_valid
      expect(access_request.errors.full_messages).to contain_exactly('Phone number must be 10 numeric digits')
    end

    it 'requires only numeric phone' do
      access_request.phone = 'abc1231234'
      expect(access_request).not_to be_valid
      expect(access_request.errors.full_messages).to contain_exactly('Phone number must be 10 numeric digits')
    end

    it 'requires request_reason' do
      access_request.request_reason = nil
      expect(access_request).not_to be_valid
    end
  end

  context 'callbacks' do
    let(:access_request) { FactoryBot.build(:access_request) }

    it 'calls admin notification mailer on create' do
      success_obj = stub(deliver_later: true)
      AdminMailer.expects(:new_access_request).once.with(instance_of(Integer)).returns(success_obj)
      access_request.save
    end

    it 'does not call admin mailer on update' do
      access_request.save
      AdminMailer.expects(:new_access_request).never
      access_request.update(full_name: 'new name')
    end
  end
end

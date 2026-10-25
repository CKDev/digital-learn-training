require 'rails_helper'

describe Organization do
  describe 'validations' do
    let(:organization) { described_class.new }

    it 'requires a title' do
      expect(organization).not_to be_valid
      expect(organization.errors.full_messages).to include("Title can't be blank")
    end

    it 'allows multiple access_request_emails' do
      organization.access_request_emails = ['test1@example.com', 'test2@example.com']
      expect(organization.access_request_emails).to contain_exactly('test1@example.com', 'test2@example.com')
    end

    describe 'button color' do
      before { organization.title = 'Test Org' }

      it 'allows a blank button color' do
        organization.buttons = { 'shape' => 'rounded' }
        expect(organization).to be_valid
      end

      it 'allows 3 and 6 digit hex colors' do
        %w[#0af #01579B].each do |color|
          organization.buttons = { 'color' => color }
          expect(organization).to be_valid
        end
      end

      it 'rejects non-hex colors' do
        %w[blue #01579 01579B #GGGGGG].each do |color|
          organization.buttons = { 'color' => color }
          expect(organization).not_to be_valid
          expect(organization.errors.full_messages).to include('Button color must be a hex color code (e.g. #01579B)')
        end
      end
    end
  end
end

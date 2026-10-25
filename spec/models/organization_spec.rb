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

    describe 'theme colors' do
      before { organization.title = 'Test Org' }

      it 'allows blank colors' do
        organization.buttons = { 'shape' => 'rounded' }
        organization.palette = { 'primary' => { 'main' => '' } }
        expect(organization).to be_valid
      end

      it 'allows hex, rgb(a), and hsl(a) colors' do
        ['#0af', '#01579B', '#01579Bcc', 'rgba(0, 0, 0, 0.56)', 'rgb(0 0 0 / 50%)', 'hsl(200, 50%, 40%)'].each do |color|
          organization.buttons = { 'color' => color }
          organization.palette = { 'primary' => { 'main' => color }, 'iconColor' => color }
          expect(organization).to be_valid
        end
      end

      it 'rejects an invalid button color' do
        organization.buttons = { 'color' => 'blue' }
        expect(organization).not_to be_valid
        expect(organization.errors.full_messages).to include(
          'Button Color must be a valid color (e.g. #01579B or rgba(0, 0, 0, 0.56))'
        )
      end

      it 'rejects invalid palette colors' do
        %w[blue #01579 01579B #GGGGGG rgba(0,0)].each do |color|
          organization.palette = { 'info' => { 'dark' => color } }
          expect(organization).not_to be_valid
          expect(organization.errors.full_messages).to include(
            'Info (Dark) must be a valid color (e.g. #01579B or rgba(0, 0, 0, 0.56))'
          )
        end
      end
    end
  end
end

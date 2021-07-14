require 'rails_helper'

describe Organization do
  describe 'validations' do
    let(:subject) { Organization.new }

    it 'requires a title'do
      expect(subject).not_to be_valid
      expect(subject.errors.full_messages).to include("Title can't be blank")
    end
  end
end

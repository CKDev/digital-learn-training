require 'rails_helper'

describe Duration do

  describe '.duration_str' do

    it 'returns the number of seconds in minutes : seconds format' do
      seconds = 60
      expect(described_class.duration_str(seconds)).to eq '01:00'
    end

    it 'returns the 00:00 if a negative number is given' do
      seconds = -1
      expect(described_class.duration_str(seconds)).to eq '00:00'
    end

  end

  describe '.minutes_str' do

    it 'returns the number of seconds in regular language' do
      seconds = 60
      expect(described_class.minutes_str(seconds)).to eq '1 min'
    end

    it 'returns the number of seconds in regular language' do
      seconds = 50
      expect(described_class.minutes_str(seconds)).to eq '0 mins'
    end

    it 'returns the 00:00 if a negative number is given' do
      seconds = -1
      expect(described_class.minutes_str(seconds)).to eq '0 mins'
    end

  end

  describe '.duration_str_to_int' do

    it 'returns the number of seconds in regular language' do
      str = '01:00'
      expect(described_class.duration_str_to_int(str)).to eq 60
    end

    it 'returns the 00:00 if a negative number is given' do
      str = '00:00'
      expect(described_class.duration_str_to_int(str)).to eq 0
    end

    it 'returns the 00:00 if a negative number is given' do
      str = '01:30'
      expect(described_class.duration_str_to_int(str)).to eq 90
    end

  end

end

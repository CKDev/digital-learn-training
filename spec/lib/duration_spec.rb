require "rails_helper"

describe Duration do

  context ".duration_str" do

    it "should return the number of seconds in minutes : seconds format" do
      seconds = 60
      expect(Duration.duration_str(seconds)).to eq "01:00"
    end

    it "should return the 00:00 if a negative number is given" do
      seconds = -1
      expect(Duration.duration_str(seconds)).to eq "00:00"
    end

  end

  context ".minutes_str" do

    it "should return the number of seconds in regular language" do
      seconds = 60
      expect(Duration.minutes_str(seconds)).to eq "1 min"
    end

    it "should return the number of seconds in regular language" do
      seconds = 50
      expect(Duration.minutes_str(seconds)).to eq "0 mins"
    end

    it "should return the 00:00 if a negative number is given" do
      seconds = -1
      expect(Duration.minutes_str(seconds)).to eq "0 mins"
    end

  end

  context ".duration_str_to_int" do

    it "should return the number of seconds in regular language" do
      str = "01:00"
      expect(Duration.duration_str_to_int(str)).to eq 60
    end

    it "should return the 00:00 if a negative number is given" do
      str = "00:00"
      expect(Duration.duration_str_to_int(str)).to eq 0
    end

    it "should return the 00:00 if a negative number is given" do
      str = "01:30"
      expect(Duration.duration_str_to_int(str)).to eq 90
    end

  end

end

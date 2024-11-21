require "rails_helper"

describe DateFormats do

  it "returns the expected date format for datetime" do
    t = Time.zone.local(2016, 9, 1, 10, 5, 0)
    expect(t.strftime(described_class.datetime)).to eq "Sep 01, 2016 10:05 AM"
  end

  it "returns the expected date format for month" do
    t = Time.zone.local(2016, 9, 1, 10, 5, 0)
    expect(t.strftime(described_class.month)).to eq "Sep"
  end

  it "returns the expected date format for day" do
    t = Time.zone.local(2016, 9, 1, 10, 5, 0)
    expect(t.strftime(described_class.day)).to eq "01"
  end

  it "returns the expected date format for month_day" do
    t = Time.zone.local(2016, 9, 1, 10, 5, 0)
    expect(t.strftime(described_class.month_day)).to eq "Sep 01"
  end

  it "returns the expected date format for month_day_year" do
    t = Time.zone.local(2016, 9, 1, 10, 5, 0)
    expect(t.strftime(described_class.month_day_year)).to eq "09/01/2016"
  end

  it "returns the expected date format for time" do
    t = Time.zone.local(2016, 9, 1, 10, 5, 0)
    expect(t.strftime(described_class.time)).to eq "10:05 AM"
  end

  it "returns the expected date format for hour" do
    t = Time.zone.local(2016, 9, 1, 10, 5, 0)
    expect(t.strftime(described_class.hour)).to eq "10"
  end

  it "returns the expected date format for minute" do
    t = Time.zone.local(2016, 9, 1, 14, 45, 0)
    expect(t.strftime(described_class.minute)).to eq "45"
  end

  it "returns the expected date format for day_of_week" do
    t = Time.zone.local(2016, 9, 1, 14, 45, 0)
    expect(t.strftime(described_class.day_of_week)).to eq "Thursday"
  end

  it "returns the expected date format for timezone" do
    t = Time.zone.local(2016, 9, 1, 14, 45, 0)
    expect(t.strftime(described_class.timezone)).to eq "UTC"
  end

end

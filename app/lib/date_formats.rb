class DateFormats

  def self.datetime
    "%b %d, %Y %l:%M %p" # "Dec 04, 2015 7:47 PM"
  end

  def self.month
    "%b" # "Sep"
  end

  def self.day
    "%d" # "04"
  end

  def self.month_day
    "%b %d" # "Sep 4"
  end

  def self.month_day_year
    "%m/%d/%Y" # 01/31/2010
  end

  def self.time
    "%l:%M %p" # "7:47 PM"
  end

  def self.hour
    "%k" # 24 hour integer format 0..23
  end

  def self.minute
    "%M" # Minute of the hour 0..59
  end

  def self.day_of_week
    "%A"
  end

  def self.timezone
    Time.zone.now.strftime("%Z") # MDT
  end

end

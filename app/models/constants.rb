class Constants
  def self.datetime_format
    "%b %d, %Y %l:%M %p" # "Dec 04, 2015 7:47 PM"
  end

  def self.month_format
    "%b" # "Sep"
  end

  def self.day_format
    "%d" # "04"
  end

  def self.month_day_format
    "%b %d" # "Sep 4"
  end

  def self.long_month_day_year_format
    "%B %e, %Y" # August 3, 2017
  end

  def self.time_format
    "%l:%M %p" # "7:47 PM"
  end

  def self.hour_format
    "%k" # 24 hour integer format 0..23
  end

  def self.minute_format
    "%M" # Minute of the hour 0..59
  end

  def self.month_day_year
    "%m/%d/%Y" # 01/31/2010
  end

  def self.calendar_format
    "%Y-%m-%d %H:%M:%S"
  end

  def self.day_of_week_format
    "%A"
  end

  def self.filename_date_format
    "%Y%m%d%H%M" # 201010311015
  end

  def self.timezone
    Time.zone.now.strftime("%Z") # MDT
  end

  def self.acceptable_doc_types
    types = [
      "application/msword", "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
      "application/vnd.openxmlformats-officedocument.presentationml.presentation"
    ]
    types.join(", ")
  end

end

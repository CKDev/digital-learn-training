module URI
  def self.escape(url)
    parser = URI::Parser.new
    parser.escape(url)
  end
end
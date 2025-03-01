class CourseMaterialVideo < ApplicationRecord
  belongs_to :course_material
  validates :url, presence: true, video: true

  after_validation :parse_url

  def parse_url
    return false if self.url.blank?

    self.url = parse_iframe || parse_embed_code
  end

  def parse_embed_code
    source = URI.parse(self.url).host
    if ['www.youtube.com', 'youtube.com', 'youtu.be', 'www.youtu.be'].include?(source)
      path = URI.parse(self.url).path
      if path.match(/embed\/(.+)/)
        self.url
      else
        youtube_id = self.url.match(/(?:.be\/|\/watch\?v=|\/(?=p\/))([\w\/-]+)/)[1]
        "https://www.youtube.com/embed/#{youtube_id}"
      end
    else
      false
    end
  rescue StandardError
    false
  end

  def parse_iframe
    parser = Nokogiri::HTML(self.url)
    parser.css('iframe').first['src']
  rescue StandardError
    false
  end
end

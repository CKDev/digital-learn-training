class VideoValidator < ActiveModel::EachValidator

  # NOTE: This needs to stay in sync with the after_validation callback of the course_material_video model, they are nearly the same
  # but the return values have different purposes.

  def validate_each(record, attribute, value)
    return if value.blank?

    r = parse_iframe(value) || parse_embed_code(value)
    record.errors.add(attribute, (options[:message] || 'is not a valid video Link/URL')) unless r
  end

  private

  def parse_embed_code(url)
    source = URI.parse(url).host
    if ['www.youtube.com', 'youtube.com', 'youtu.be', 'www.youtu.be'].include?(source)
      return true
    end

    false
  rescue StandardError
    false
  end

  def parse_iframe(url)
    parser = Nokogiri::HTML(url)
    parser.css('iframe').first['src']
  rescue StandardError
    false
  end
end

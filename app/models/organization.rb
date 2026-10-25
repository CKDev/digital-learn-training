class Organization < ApplicationRecord
  # Color formats MUI can parse. Keep in sync with app/frontend/components/utils/colors.js.
  COLOR_REGEX = %r{\A(\#(\h{3,4}|\h{6}|\h{8})|(rgba?|hsla?)\(\s*[\d.]+%?(\s*[,\s/]\s*[\d.]+%?){2,3}\s*\))\z}i.freeze

  resourcify
  has_many :categories, dependent: :destroy
  has_many :course_materials, through: :categories
  has_many :course_material_imports, dependent: :destroy
  has_many :imported_course_materials, through: :course_material_imports, source: :course_material

  validates :title, presence: true
  validate :theme_colors_are_valid
  store_accessor :settings, :access_requests_enabled, :access_request_emails, :authentication_required,
    :trainers_only
  store_accessor :theme_overrides, :palette, :buttons

  has_attached_file :header_logo, url: 'organizations/:id/header_logo/:basename.:extension'
  validates_attachment_content_type :header_logo, content_type: Constants.course_material_media_types,
    message: 'Only PNG, JPG, GIF and WebP files are allowed.'

  has_attached_file :footer_logo, url: 'organizations/:id/footer_logo/:basename.:extension'
  validates_attachment_content_type :footer_logo, content_type: Constants.course_material_media_types,
    message: 'Only PNG, JPG, GIF and WebP files are allowed.'

  def to_props
    {
      id: id,
      title: title
    }
  end

  def can_import_courses?
    subdomain != 'att' # For now, AT&T can't import
  end

  def trainers_only?
    ActiveModel::Type::Boolean.new.cast(trainers_only)
  end

  def self.digital_learn
    find_by(subdomain: 'www')
  end

  private

  THEME_COLOR_LABELS = {
    %w[palette primary main] => 'Primary (Main)',
    %w[palette primary light] => 'Primary (Light)',
    %w[palette info main] => 'Info (Main)',
    %w[palette info dark] => 'Info (Dark)',
    %w[palette info contrastText] => 'Info (Contrast Text)',
    %w[palette iconColor] => 'Icon Color',
    %w[buttons color] => 'Button Color',
  }.freeze

  def theme_colors_are_valid
    THEME_COLOR_LABELS.each do |path, label|
      color = theme_overrides&.dig(*path)
      next if color.blank? || (color.is_a?(String) && color.strip.match?(COLOR_REGEX))

      errors.add(:base, "#{label} must be a valid color (e.g. #01579B or rgba(0, 0, 0, 0.56))")
    end
  end
end

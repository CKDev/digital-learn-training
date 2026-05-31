class Organization < ApplicationRecord
  resourcify
  has_many :categories, dependent: :destroy
  has_many :course_materials, through: :categories
  has_many :course_material_imports, dependent: :destroy
  has_many :imported_course_materials, through: :course_material_imports, source: :course_material

  validates :title, presence: true
  store_accessor :settings, :access_requests_enabled, :access_request_emails, :authentication_required
  store_accessor :theme_overrides, :palette

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
end

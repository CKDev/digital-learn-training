class Organization < ApplicationRecord
  resourcify
  has_many :categories, dependent: :destroy
  has_many :course_materials, through: :categories
  has_many :course_material_imports, dependent: :destroy
  has_many :imported_course_materials, through: :course_material_imports, source: :course_material

  validates :title, presence: true
  store_accessor :settings, :access_requests_enabled, :access_request_emails, :authentication_required
  store_accessor :theme_overrides, :palette

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

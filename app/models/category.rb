class Category < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :organization, optional: true

  ALLOWED_TAGS = ['Getting Started', 'Hardware', 'Software & Applications', 'Job & Career', 'Other'].freeze
  has_many :sub_categories, dependent: :destroy

  has_many :course_materials, dependent: :destroy

  validates :title, presence: true
  validates :tag, presence: true, inclusion: { in: ALLOWED_TAGS.map(&:to_s) }

  accepts_nested_attributes_for :sub_categories, reject_if: :all_blank, allow_destroy: true
  validates_associated :sub_categories

  scope :with_published_course_materials, -> { joins(:course_materials).where(course_materials: { pub_status: 'P' }).distinct }

  def self.select_options
    ALLOWED_TAGS.reject { |t| t == 'Other' }.map { |t| [t, t] }
  end

  def to_props(include_materials: false)
    props = {
      id: id,
      friendlyId: friendly_id,
      title: title,
      tag: tag,
      description: description,
      subcategories: sub_categories.map(&:to_props),
      organization: organization&.to_props
    }

    if include_materials
      props.merge!({ courseMaterials: course_materials.published.map(&:to_props) })
    end

    props
  end
end

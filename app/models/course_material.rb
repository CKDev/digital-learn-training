class CourseMaterial < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :category
  belongs_to :sub_category, required: false
  has_many :course_material_files, dependent: :destroy
  has_many :course_material_medias, dependent: :destroy
  has_many :course_material_videos, dependent: :destroy

  validates :title, length: { maximum: 90 }, presence: true
  validate :unique_title
  validates :contributor, length: { maximum: 156 }, presence: true
  validates :summary, presence: true, length: { maximum: 74 }
  validates :pub_status, presence: true,
    inclusion: { in: %w(P D A), message: "%{value} is not a valid status" }
  validates :language, presence: true, inclusion: { in: %w(en es) }
  validate :allowed_change?
  validates :sort_order, presence: true, numericality: { only_integer: true, greater_than: 0 }

  accepts_nested_attributes_for :course_material_files, reject_if: :all_blank, allow_destroy: true
  validates_associated :course_material_files

  accepts_nested_attributes_for :course_material_medias, reject_if: :all_blank, allow_destroy: true
  validates_associated :course_material_medias

  accepts_nested_attributes_for :course_material_videos, reject_if: :all_blank, allow_destroy: true
  validates_associated :course_material_videos

  # Zipped attachments
  has_attached_file :file_archive, url: "course_material_file_archives/:id/:basename.:extension"
  has_attached_file :media_archive, url: "course_material_media_archives/:id/:basename.:extension"

  validates_attachment :file_archive, content_type: { content_type: ["application/zip", "application/x-zip"] }
  validates_attachment :media_archive, content_type: { content_type: ["application/zip", "application/x-zip"] }

  default_scope { order("sort_order") }
  scope :in_category, ->(category_id) { joins(:category).where("categories.id = ?", category_id) }
  scope :published, -> { where(pub_status: "P") }
  scope :archived, -> { where(pub_status: "A") }
  scope :not_archived, -> { where.not(pub_status: "A") }
  scope :not_self, ->(id) { where.not(id: id) }
  scope :non_organization, -> { joins(:category).where(categories: { organization_id: nil }).references(:categories) }
  scope :in_language, ->(language) { where(language: language) }

  private

  def allowed_change?
    # We need to count on certain nodes being in the system - certain content we don't want
    # to be deleted or changed.

    # There must be a homepage witht the slug "home", otherwise the site will show the PushType
    # welcome page, which is bad.
    PROTECTED_COURSE_MATERIALS.each do |t|
      if self.title_was == t && self.title != t
        errors.add(:title, "This course is protected and cannot be changed.")
      end
    end

  end

  def unique_title
    scope = category&.organization.present? ? category.organization.course_materials : CourseMaterial.non_organization
    errors.add(:title, 'has already been taken') if scope.where(title: title).where.not(id: id).exists?
  end

end

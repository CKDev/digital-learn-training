class CourseMaterial < ApplicationRecord
  belongs_to :category
  belongs_to :sub_category, required: false
  has_many :course_material_files, dependent: :destroy
  has_many :course_material_medias, dependent: :destroy
  has_many :course_material_videos, dependent: :destroy

  validates :title, length: { maximum: 90 }, presence: true, uniqueness: true
  validates :contributor, length: { maximum: 156 }, presence: true
  validates :summary, length: { maximum: 156 }
  validates :pub_status, presence: true,
    inclusion: { in: %w(P D A), message: "%{value} is not a valid status" }

  accepts_nested_attributes_for :course_material_files, reject_if: :all_blank, allow_destroy: true
  validates_associated :course_material_files

  accepts_nested_attributes_for :course_material_medias, reject_if: :all_blank, allow_destroy: true
  validates_associated :course_material_medias

  accepts_nested_attributes_for :course_material_videos, reject_if: :all_blank, allow_destroy: true
  validates_associated :course_material_videos

  scope :in_category, ->(category_id) { joins(:category).where("categories.id = ?", category_id) }
  scope :published, -> { where(pub_status: "P") }
  scope :archived, -> { where(pub_status: "A") }
  scope :not_archived, -> { where.not(pub_status: "A") }
  scope :not_self, ->(id) { where.not(id: id) }

end

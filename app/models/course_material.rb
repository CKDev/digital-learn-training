class CourseMaterial < ApplicationRecord
  belongs_to :category
  belongs_to :sub_category, required: false
  has_many :course_material_files, dependent: :destroy
  has_many :course_material_medias, dependent: :destroy

  validates :title, length: { maximum: 90 }, presence: true, uniqueness: true
  validates :contributor, length: { maximum: 156 }, presence: true
  validates :summary, length: { maximum: 156 }

  accepts_nested_attributes_for :course_material_files, reject_if: :all_blank, allow_destroy: true
  validates_associated :course_material_files

  accepts_nested_attributes_for :course_material_medias, reject_if: :all_blank, allow_destroy: true
  validates_associated :course_material_medias

  scope :in_category, ->(category_id) { joins(:category).where("categories.id = ?", category_id) }
  scope :archived, -> { where(archived: true) }
  scope :not_archived, -> { where(archived: false) }
  scope :not_self, ->(id) { where.not(id: id) }
end

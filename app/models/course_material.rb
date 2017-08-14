class CourseMaterial < ApplicationRecord

  validates :title, length: { maximum: 90 }, presence: true, uniqueness: true
  validates :contributor, length: { maximum: 156 }, presence: true
  validates :summary, length: { maximum: 156 }

end

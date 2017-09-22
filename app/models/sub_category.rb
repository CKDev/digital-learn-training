class SubCategory < ApplicationRecord
  belongs_to :category
  has_many :course_materials

  validates :title, presence: true # , length: { maximum: 90 }, uniqueness: true  # TODO: need test for this.
end

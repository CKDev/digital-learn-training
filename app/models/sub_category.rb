class SubCategory < ApplicationRecord
  belongs_to :category
  has_many :course_materials, dependent: :destroy

  validates :title, presence: true # , length: { maximum: 90 }, uniqueness: true  # TODO: need test for this.

  def to_props
    {
      id: id,
      title: title
    }
  end
end

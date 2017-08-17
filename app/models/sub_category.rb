class SubCategory < ApplicationRecord
  belongs_to :category
  has_many :course_materials
end

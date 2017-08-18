class Category < ApplicationRecord
  has_many :sub_categories

  accepts_nested_attributes_for :sub_categories, reject_if: :all_blank, allow_destroy: true
  validates_associated :sub_categories
end

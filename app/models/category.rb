class Category < ApplicationRecord
  ALLOWED_TAGS = ["Hardware", "Software & Applications", "Job & Career", "Other"].freeze
  has_many :sub_categories

  validates :title, presence: true
  validates :tag, presence: true, inclusion: { in: ALLOWED_TAGS.map(&:to_s), message: "%{value} is not valid" }

  accepts_nested_attributes_for :sub_categories, reject_if: :all_blank, allow_destroy: true
  validates_associated :sub_categories

  def self.select_options
    ALLOWED_TAGS.reject { |t| t == "Other" }.map { |t| [t, t] }
  end
end

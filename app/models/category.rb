class Category < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :organization, optional: true

  ALLOWED_TAGS = ["Getting Started", "Hardware", "Software & Applications", "Job & Career", "Other"].freeze
  has_many :sub_categories

  has_many :course_materials

  validates :title, presence: true
  validates :tag, presence: true, inclusion: { in: ALLOWED_TAGS.map(&:to_s), message: "%<value>s is not valid" }

  accepts_nested_attributes_for :sub_categories, reject_if: :all_blank, allow_destroy: true
  validates_associated :sub_categories

  def self.select_options
    ALLOWED_TAGS.reject { |t| t == "Other" }.map { |t| [t, t] }
  end
end

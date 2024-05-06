class Organization < ApplicationRecord
  has_many :categories
  has_many :course_materials, through: :categories

  validates :title, presence: true
  store_accessor :settings, :access_requests_enabled
end

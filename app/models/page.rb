class Page < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  validates :title, presence: true, uniqueness: true, length: { maximum: 90 }
  validates :body, presence: true
  validates :author, presence: true, length: { maximum: 20 }
  validates :seo_title, length: { maximum: 90 }
  validates :meta_desc, length: { maximum: 156 }
  validates :pub_status, presence: true,
    inclusion: { in: %w(P D A), message: "%{value} is not a valid status" }

  scope :alpha_order, -> { order(:title) }
  scope :published, -> { where(pub_status: "P") }
  scope :archived, -> { where(pub_status: "A") }
  scope :not_archived, -> { where.not(pub_status: "A") }

end

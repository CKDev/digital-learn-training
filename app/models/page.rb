class Page < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  validates :title, presence: true, uniqueness: true, length: { maximum: 90 }
  validates :body, presence: true
  validates :author, presence: true, length: { maximum: 20 }
  validates :seo_title, length: { maximum: 90 }
  validates :meta_desc, length: { maximum: 156 }
  validates :pub_status, presence: true, inclusion: { in: %w(P D A), message: "%<value>s is not a valid status" }

  before_save :update_pub_at

  scope :alpha_order, -> { order(:title) }
  scope :published, -> { where(pub_status: "P") }
  scope :archived, -> { where(pub_status: "A") }
  scope :not_archived, -> { where.not(pub_status: "A") }

  def update_pub_at
    pub_status == "P" ? self.pub_at = Time.zone.now : self.pub_at = nil
    true # Since this is used from a callback.
  end

end

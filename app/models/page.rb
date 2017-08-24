class Page < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  validates :title, presence: true, uniqueness: true, length: { maximum: 90 }
  validates :body, presence: true
  validates :author, presence: true, length: { maximum: 20 }
  validates :seo_title, length: { maximum: 90 }
  validates :meta_desc, length: { maximum: 156 }

  enum pub_status: [:draft, :published, :archived]

  scope :alpha_order, -> { order(:title) }
  scope :published, -> { where("pub_status = ?", Page.pub_statuses["published"]) }
  scope :archived, -> { where("pub_status = ?", Page.pub_statuses["archived"]) }
  scope :not_archived, -> { where.not("pub_status = ?", Page.pub_statuses["archived"]) }

  def self.pub_status_select_options
    Page.pub_statuses.map { |k, _v| [k.titleize, k] }
  end

end

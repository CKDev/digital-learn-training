class Organization < ApplicationRecord
  resourcify
  has_many :categories, dependent: :destroy
  has_many :course_materials, through: :categories

  validates :title, presence: true
  store_accessor :settings, :access_requests_enabled, :access_request_emails, :authentication_required
  store_accessor :theme_overrides, :palette

  def to_props
    {
      id: id,
      title: title
    }
  end
end

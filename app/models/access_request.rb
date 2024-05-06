class AccessRequest < ApplicationRecord
  belongs_to :organization

  validates :full_name, presence: true
  validates :organization_name, presence: true
  validates :email, presence: true
  validates :phone, presence: true, numericality: true, length: { is: 10 }
  validates :request_reason, presence: true
end

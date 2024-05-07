class AccessRequest < ApplicationRecord
  belongs_to :organization

  validates :full_name, presence: true
  validates :organization_name, presence: true
  validates :email, presence: true
  validates :phone, presence: true
  validates :request_reason, presence: true

  before_validation :verify_phone_number

  private

  def verify_phone_number
    return unless phone.present?
    self.phone = phone.gsub(/\D/, '')

    if !phone.match(/^\d{10}$/)
      errors.add(:phone, "must be 10 numeric digits")
    end
  end
end

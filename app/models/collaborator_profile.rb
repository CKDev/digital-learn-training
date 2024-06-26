class CollaboratorProfile < ApplicationRecord
  belongs_to :user

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :organization_name, presence: true
  validates :organization_city, presence: true
  validates :organization_state, presence: true
  validates :poc_name, presence: true
  validates :poc_email, presence: true
  validates :terms_of_service, acceptance: true

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

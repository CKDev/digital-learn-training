class AccessRequest < ApplicationRecord
  belongs_to :organization

  validates :full_name, presence: true
  validates :organization_name, presence: true
  validates :email, presence: true
  validates :phone, presence: true
  validates :request_reason, presence: true

  before_validation :verify_phone_number

  after_create :send_email_notificatioin

  private

  def verify_phone_number
    return unless phone.present?

    self.phone = phone.gsub(/\D/, "")

    unless phone.match(/^\d{10}$/)
      errors.add(:phone, "must be 10 numeric digits")
    end
  end

  def send_email_notificatioin
    AdminMailer.new_access_request(self.id).deliver_later
  end
end

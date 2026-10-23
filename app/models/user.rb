class User < ApplicationRecord
  rolify
  has_one :collaborator_profile, dependent: :destroy
  accepts_nested_attributes_for :collaborator_profile

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable,
         :registerable,
         :rememberable,
         :trackable,
         :validatable,
         :saml_authenticatable,
         :invitable

  def admin?
    admin
  end

  def collaborator?
    collaborator_profile.present?
  end

  # Organization whose subdomain should be used for links in account emails.
  # Falls back to the organization access was requested through, for users who
  # have not accepted their invitation yet.
  def mailer_organization
    roles.where(name: %w[organization_admin collaborator]).first&.resource ||
      AccessRequest.where('LOWER(email) = ?', email.downcase).order(created_at: :desc).first&.organization
  end

  private

  def password_required?
    ['saml', 'dl_sso'].exclude?(provider) && super
  end
end

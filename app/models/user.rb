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

  private

  def password_required?
    provider != "saml" && super
  end

end

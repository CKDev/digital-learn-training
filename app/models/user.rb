class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :registerable,
    :rememberable, :trackable, :validatable, :saml_authenticatable

  def admin?
    admin
  end

  private

  def password_required?
    provider != 'saml'
  end

end

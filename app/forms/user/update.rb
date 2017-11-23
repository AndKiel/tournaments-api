class User < ApplicationRecord
  class Update < Reform::Form
    property :email
    property :password, virtual: true
    property :password_confirmation, virtual: true
    property :password_digest

    validates :email,
              presence: true,
              unique: true

    validate :password_confirmed?

    def password_confirmed?
      errors.add(:password_confirmation, I18n.t('errors.password_confirmed?')) if password != password_confirmation
    end
  end
end

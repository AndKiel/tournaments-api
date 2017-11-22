class User < ApplicationRecord
  class SignUp < Reform::Form
    property :email
    property :password, virtual: true
    property :password_confirmation, virtual: true
    property :password_digest

    validation :default do
      validates :email,
                presence: true,
                unique: true

      validates :password,
                presence: true

      validates :password_confirmation,
                presence: true
    end

    validation :confirmation, if: :default do
      validate :password_confirmed?
    end

    def password_confirmed?
      errors.add(:password_confirmation, I18n.t('errors.password_confirmed?')) if password != password_confirmation
    end
  end
end

class User < ApplicationRecord
  class BaseForm < Reform::Form
    property :email
    property :password, readable: false
    property :password_confirmation, virtual: true

    validates :email,
              presence: true,
              email_format: true,
              unique: true

    def password_confirmed?
      errors.add(:password_confirmation, I18n.t('errors.password_confirmed?')) if password != password_confirmation
    end
  end
end

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
      errors.add(:password_confirmation, :password_mismatch) if password != password_confirmation
    end
  end
end

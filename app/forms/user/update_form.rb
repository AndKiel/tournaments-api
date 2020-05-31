# frozen_string_literal: true

class User < ApplicationRecord
  class UpdateForm
    property :email
    property :password, readable: false
    property :password_confirmation, virtual: true

    validates :email,
              presence: true,
              email_format: true,
              unique: true

    validate :password_confirmed?

    def password_confirmed?
      errors.add(:password_confirmation, :password_mismatch) if password != password_confirmation
    end
  end
end

# frozen_string_literal: true

class User < ApplicationRecord
  class SignUpForm < Reform::Form
    property :email
    property :password, readable: false
    property :password_confirmation, virtual: true

    validation(name: :default) do
      validates :email,
                presence: true,
                email_format: true,
                unique: true

      validates :password,
                presence: true

      validates :password_confirmation,
                presence: true
    end

    validation(name: :confirmation, if: :default) do
      validate :password_confirmed?
    end

    def password_confirmed?
      errors.add(:password_confirmation, :password_mismatch) unless password == password_confirmation
    end
  end
end

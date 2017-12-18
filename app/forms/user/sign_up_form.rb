class User < ApplicationRecord
  class SignUpForm < BaseForm
    validation :default do
      validates :password,
                presence: true

      validates :password_confirmation,
                presence: true
    end

    validation :confirmation, if: :default do
      validate :password_confirmed?
    end
  end
end

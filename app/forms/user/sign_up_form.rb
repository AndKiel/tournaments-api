# frozen_string_literal: true

class User < ApplicationRecord
  class SignUpForm < BaseForm
    validation(name: :default) do
      validates :password,
                presence: true

      validates :password_confirmation,
                presence: true
    end

    validation(name: :confirmation, if: :default) do
      validate :password_confirmed?
    end
  end
end

# frozen_string_literal: true

class User < ApplicationRecord
  class SignUpForm < BaseForm
    validation do
      params do
        required(:password).filled(:str?)
        required(:password_confirmation).filled(:str?)
      end

      rule(:password, :password_confirmation) do
        key(:password_confirmation).failure(I18n.t('errors.messages.password_mismatch')) if values[:password] != values[:password_confirmation]
      end
    end
  end
end

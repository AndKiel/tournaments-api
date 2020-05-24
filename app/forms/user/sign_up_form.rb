# frozen_string_literal: true

class User < ApplicationRecord
  class SignUpForm < BaseForm
    validation do
      params do
        required(:password).filled(:str?)
        required(:password_confirmation).filled(:str?)
      end

      rule(:password, :password_confirmation) do
        if values[:password] != values[:password_confirmation]
          key(:password_confirmation).failure(I18n.t('errors.messages.password_mismatch'))
        end
      end
    end
  end
end

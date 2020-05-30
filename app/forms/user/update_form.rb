# frozen_string_literal: true

class User < ApplicationRecord
  class UpdateForm < BaseForm
    validation do
      params do
        optional(:password).maybe(:str?)
        optional(:password_confirmation).maybe(:str?)
      end

      rule(:password, :password_confirmation) do
        if values[:password] != values[:password_confirmation]
          key(:password_confirmation).failure(I18n.t('errors.messages.password_mismatch'))
        end
      end
    end
  end
end

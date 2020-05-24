# frozen_string_literal: true

class User < ApplicationRecord
  class BaseForm < Reform::Form
    property :email
    property :password, readable: false
    property :password_confirmation, virtual: true

    validation do
      option :form

      params do
        required(:email).filled(:str?)
      end

      rule(:email) do
        key.failure(I18n.t('errors.messages.invalid_email')) if ValidatesEmailFormatOf.validate_email_format(value)
        key.failure(I18n.t('errors.messages.taken')) if User.where.not(id: form.model.id).find_by(email: value)
      end
    end
  end
end

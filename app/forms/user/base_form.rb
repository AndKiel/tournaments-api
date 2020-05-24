# frozen_string_literal: true

class User < ApplicationRecord
  class BaseForm < Reform::Form
    property :email
    property :password, readable: false
    property :password_confirmation, virtual: true

    validation do
      params do
        required(:email).filled(:str?)
      end

      # FIXME: How to access form/model from dry?
      rule(:email) do
        key.failure(I18n.t('errors.messages.invalid_email')) if ValidatesEmailFormatOf.validate_email_format(value)
        # key.failure(:taken) unless User.where.not(id: form.model.id).find_by(email: value).nil?
      end
    end
  end
end

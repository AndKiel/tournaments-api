# frozen_string_literal: true

class User < ApplicationRecord
  class SignUpContract < ApplicationContract
    option :model

    json do
      required(:email).filled(:str?)
      required(:password).filled(:str?)
      required(:password_confirmation).filled(:str?)
    end

    rule(:email) do
      key.failure(I18n.t('errors.messages.invalid_email')) if ValidatesEmailFormatOf.validate_email_format(value)
      key.failure(I18n.t('errors.messages.taken')) if User.where(email: value).where.not(id: model.id).exists?
    end

    rule(:password, :password_confirmation) do
      if values[:password] != values[:password_confirmation]
        key(:password_confirmation).failure(I18n.t('errors.messages.confirmation', attribute: 'password'))
      end
    end
  end
end

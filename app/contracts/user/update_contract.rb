# frozen_string_literal: true

class User < ApplicationRecord
  class UpdateContract < ApplicationContract
    option :model

    json do
      optional(:email).value(:str?, :filled?)
      optional(:password).value(:str?)
      optional(:password_confirmation).value(:str?)
    end

    rule(:email) do
      if ValidatesEmailFormatOf.validate_email_format(value)
        key.failure(:email?)
      elsif User.where(email: value).where.not(id: model.id).exists?
        key.failure(:unique?)
      end
    end

    rule(:password, :password_confirmation) do
      if values[:password] != values[:password_confirmation]
        key(:password_confirmation).failure(:confirmed?, key: :password)
      end
    end
  end
end

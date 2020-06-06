# frozen_string_literal: true

class User < ApplicationRecord
  class SignUpContract < ApplicationContract
    json do
      required(:email).value(:str?, :filled?)
      required(:password).value(:str?, :filled?)
      required(:password_confirmation).value(:str?, :filled?)
    end

    rule(:email) do
      if ValidatesEmailFormatOf.validate_email_format(value)
        key.failure(:email?)
      elsif User.where(email: value).exists?
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

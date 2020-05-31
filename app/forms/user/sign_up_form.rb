# frozen_string_literal: true

class User < ApplicationRecord
  class SignUpForm < Reform::Form
    property :email
    property :password, readable: false
    property :password_confirmation, virtual: true

    validates :email,
              presence: true,
              email_format: true,
              unique: true

    validates :password,
              presence: true,
              confirmation: true
  end
end

class User < ApplicationRecord
  class UpdateForm < BaseForm
    validate :password_confirmed?
  end
end

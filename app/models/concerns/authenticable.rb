module Authenticable
  extend ActiveSupport::Concern

  included do
    def password
      BCrypt::Password.new(password_digest)
    end

    def password=(new_password)
      self.password_digest = BCrypt::Password.create(new_password) if new_password.present?
    end
  end
end

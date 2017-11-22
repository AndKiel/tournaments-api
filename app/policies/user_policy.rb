class UserPolicy < ApplicationPolicy
  def permitted_attributes_for_sign_up
    %i[email password password_confirmation]
  end

  def sign_up?
    true
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end

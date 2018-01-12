class UserPolicy < ApplicationPolicy
  def permitted_attributes
    %i[email password password_confirmation]
  end

  def sign_up?
    true
  end

  def show?
    user.id == record.id
  end

  def update?
    user.id == record.id
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end

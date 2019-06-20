# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end


  # :nocov:
  def permitted_attributes
    raise NotImplementedError, 'Subclasses must define `permitted_attributes`.'
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def update?
    false
  end

  def destroy?
    false
  end


  def scope
    Pundit.policy_scope!(user, record.class)
  end
  # :nocov:

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end

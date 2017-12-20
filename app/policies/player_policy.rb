class PlayerPolicy < ApplicationPolicy
  def permitted_attributes
    [
      result_values: []
    ]
  end

  def update?
    record.tournament.status.in_progress?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end

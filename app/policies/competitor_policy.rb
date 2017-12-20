class CompetitorPolicy < ApplicationPolicy
  def create?
    record.tournament.status.created?
  end

  def destroy?
    record.tournament.status.created?
  end

  def confirm?
    record.status.enlisted? && record.tournament.status.created?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end

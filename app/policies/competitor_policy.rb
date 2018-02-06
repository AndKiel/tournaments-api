class CompetitorPolicy < ApplicationPolicy
  def permitted_attributes
    %i[name]
  end

  def create?
    record.tournament.status.created?
  end

  def destroy?
    record.tournament.status.created?
  end

  def confirm?
    record.status.enlisted? && record.tournament.status.created?
  end

  def reject?
    record.status.confirmed? && record.tournament.status.created?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end

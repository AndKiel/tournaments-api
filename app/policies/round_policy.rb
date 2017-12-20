class RoundPolicy < ApplicationPolicy
  def permitted_attributes
    %i[competitors_limit tables_count]
  end

  def create?
    !record.tournament.status.ended?
  end

  def update?
    !record.tournament.status.ended?
  end

  def destroy?
    !record.tournament.status.ended?
  end

  def assign_players?
    record.tournament.status.in_progress?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end

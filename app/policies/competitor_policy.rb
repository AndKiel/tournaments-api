class CompetitorPolicy < ApplicationPolicy
  def create?
    Tournament.with_status(:created).exists?(record.tournament_id) &&
      !Competitor.exists?(tournament_id: record.tournament_id, user_id: record.user_id)
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

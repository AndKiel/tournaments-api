class CompetitorPolicy < ApplicationPolicy
  def create?
    Tournament.with_status(:created).exists?(record.tournament_id) &&
      !Competitor.exists?(tournament_id: record.tournament_id, user_id: record.user_id)
  end

  def destroy?
    Tournament.with_status(:created).exists?(record.tournament_id)
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end

class TournamentPolicy < ApplicationPolicy
  def permitted_attributes
    [
      :competitors_limit,
      :description,
      :name,
      :starts_at,
      result_names: []
    ]
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.id == record.organiser_id
  end

  def update?
    user.id == record.organiser_id
  end

  def destroy?
    user.id == record.organiser_id
  end

  class Scope < Scope
    def resolve
      case user
        when User
          super.where(organiser: user)
        else
          super
      end
    end
  end
end

# frozen_string_literal: true

class RoundPolicy < ApplicationPolicy
  def permitted_attributes
    %i[competitors_limit tables_count]
  end

  def create?
    !record.tournament.ended?
  end

  def update?
    !record.tournament.ended?
  end

  def destroy?
    !record.tournament.ended?
  end

  def assign_players?
    record.tournament.in_progress?
  end
end

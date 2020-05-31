# frozen_string_literal: true

class CompetitorPolicy < ApplicationPolicy
  def permitted_attributes
    %i[name]
  end

  def create?
    record.tournament.created?
  end

  def destroy?
    record.tournament.created?
  end

  def confirm?
    record.enlisted? && record.tournament.created?
  end

  def reject?
    record.confirmed? && record.tournament.created?
  end
end

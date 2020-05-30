# frozen_string_literal: true

class PlayerPolicy < ApplicationPolicy
  def permitted_attributes
    [
      result_values: []
    ]
  end

  def update?
    record.tournament.in_progress?
  end
end

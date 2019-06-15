# frozen_string_literal: true

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

  def enlisted?
    true
  end

  def show?
    true
  end

  def results?
    true
  end

  def create?
    organised_by_user?
  end

  def update?
    organised_by_user?
  end

  def destroy?
    organised_by_user?
  end

  def start?
    organised_by_user? &&
      record.status.created? &&
      record.starts_at <= Time.current
  end

  def end?
    organised_by_user? &&
      record.status.in_progress?
  end


  def organised_by_user?
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

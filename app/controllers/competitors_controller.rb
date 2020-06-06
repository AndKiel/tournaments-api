# frozen_string_literal: true

class CompetitorsController < ApplicationController
  before_action :doorkeeper_authorize!
  after_action :verify_authorized

  # Actions for potential tournament participants

  def create
    tournament = Tournament.find(params[:tournament_id])
    competitor = current_user.competitors.find_or_initialize_by(tournament: tournament)
    authorize competitor
    contract = CompetitorContract.new(model: competitor)
    validation_result = contract.call(permitted_attributes(competitor).to_h)
    if validation_result.success?
      competitor.update!(validation_result.to_h)
      return render json: CompetitorSerializer.render(competitor, root: :competitor),
                    status: :created
    end
    render_validation_errors(validation_result)
  end

  def destroy
    competitor = current_user.competitors.find_by!(tournament_id: params[:tournament_id])
    authorize competitor
    competitor.destroy!
    head :no_content
  end

  # Actions for tournament organiser

  def add
    tournament = current_user.organised_tournaments.find(params[:tournament_id])
    competitor = tournament.competitors.new
    authorize competitor, :create?
    contract = CompetitorContract.new(model: competitor)
    validation_result = contract.call(permitted_attributes(competitor).to_h)
    if validation_result.success?
      competitor.update!(validation_result.to_h)
      return render json: CompetitorSerializer.render(competitor, root: :competitor),
                    status: :created
    end
    render_validation_errors(validation_result)
  end

  def remove
    competitor = current_user.tournament_competitors.where(user_id: nil).find(params[:id])
    authorize competitor, :destroy?
    competitor.destroy!
    head :no_content
  end

  def confirm
    competitor = current_user.tournament_competitors.find(params[:id])
    authorize competitor
    competitor.update!(status: :confirmed)
    render json: CompetitorSerializer.render(competitor, root: :competitor)
  end

  def reject
    competitor = current_user.tournament_competitors.find(params[:id])
    authorize competitor
    competitor.update!(status: :enlisted)
    render json: CompetitorSerializer.render(competitor, root: :competitor)
  end
end

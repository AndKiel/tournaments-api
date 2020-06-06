# frozen_string_literal: true

class RoundsController < ApplicationController
  before_action :doorkeeper_authorize!
  after_action :verify_authorized

  # Actions for tournament organiser

  def create
    tournament = current_user.organised_tournaments.find(params[:tournament_id])
    round = tournament.rounds.new
    authorize round
    contract = RoundContract.new
    validation_result = contract.call(permitted_attributes(round).to_h)
    if validation_result.success?
      round.update!(validation_result.to_h)
      return render json: RoundSerializer.render(round, root: :round),
                    status: :created
    end
    render_validation_errors(validation_result)
  end

  def update
    round = current_user.tournament_rounds.find(params[:id])
    authorize round
    contract = RoundContract.new
    validation_result = contract.call(permitted_attributes(round).to_h)
    if validation_result.success?
      round.update!(validation_result.to_h)
      return render json: RoundSerializer.render(round, root: :round)
    end
    render_validation_errors(validation_result)
  end

  def destroy
    round = current_user.tournament_rounds.find(params[:id])
    authorize round
    round.destroy!
    head :no_content
  end
end

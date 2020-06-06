# frozen_string_literal: true

class PlayersController < ApplicationController
  before_action :doorkeeper_authorize!
  after_action :verify_authorized

  # Actions for tournament organiser

  def create
    round = current_user.tournament_rounds.find(params[:round_id])
    authorize round, :assign_players?
    players = MatchmakingService.new(round).call
    render json: PlayerSerializer.render(players, root: :players),
           status: :created
  end

  def update
    player = current_user.tournament_players.find(params[:id])
    authorize player
    contract = PlayerContract.new(model: player)
    validation_result = contract.call(permitted_attributes(player).to_h)
    if validation_result.success?
      player.update!(validation_result.to_h)
      return render json: PlayerSerializer.render(player, root: :player)
    end
    render_validation_errors(validation_result)
  end
end

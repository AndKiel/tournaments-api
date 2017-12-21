class PlayersController < ApplicationController
  before_action :doorkeeper_authorize!
  after_action :verify_authorized

  # Actions for tournament organiser

  def create
    round = current_user.tournament_rounds.find(params[:round_id])
    authorize round, :assign_players?
    players = MatchmakingService.new(round).call
    render json: players,
           status: :created
  end

  def update
    player = current_user.tournament_players.find(params[:id])
    authorize player
    form = PlayerForm.new(player)
    if form.validate(permitted_attributes(player))
      form.save
      return render json: form.model
    end
    render_validation_errors(form)
  end
end

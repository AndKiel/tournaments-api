class PlayersController < ApplicationController
  before_action :doorkeeper_authorize!
  after_action :verify_authorized

  def create
    round = pundit_user.tournament_rounds.find(params[:round_id])
    authorize round, :assign_players?
    models = RoundMatcher.new(round).call
    render json: models,
           status: :created
  end

  def update
    model = pundit_user.tournament_players.find(params[:id])
    authorize model
    form = PlayerForm.new(model)
    if form.validate(permitted_attributes(model))
      form.save
      return render json: form.model
    end
    render_validation_errors(form)
  end
end

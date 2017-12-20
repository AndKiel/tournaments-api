class RoundsController < ApplicationController
  before_action :doorkeeper_authorize!
  after_action :verify_authorized

  def create
    tournament = pundit_user.organised_tournaments.find(params[:tournament_id])
    round = tournament.rounds.new
    authorize round
    form = RoundForm.new(round)
    if form.validate(permitted_attributes(round))
      form.save
      return render json: form.model,
                    status: :created
    end
    render_validation_errors(form)
  end

  def update
    round = pundit_user.tournament_rounds.find(params[:id])
    authorize round
    form = RoundForm.new(round)
    if form.validate(permitted_attributes(round))
      form.save
      return render json: form.model
    end
    render_validation_errors(form)
  end

  def destroy
    round = pundit_user.tournament_rounds.find(params[:id])
    authorize round
    round.destroy!
    head :no_content
  end
end

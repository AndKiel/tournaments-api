class RoundsController < ApplicationController
  before_action :doorkeeper_authorize!
  after_action :verify_authorized

  # Actions for tournament organiser

  def create
    tournament = current_user.organised_tournaments.find(params[:tournament_id])
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
    round = current_user.tournament_rounds.find(params[:id])
    authorize round
    form = RoundForm.new(round)
    if form.validate(permitted_attributes(round))
      form.save
      return render json: form.model
    end
    render_validation_errors(form)
  end

  def destroy
    round = current_user.tournament_rounds.find(params[:id])
    authorize round
    round.destroy!
    head :no_content
  end
end

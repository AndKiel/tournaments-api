class RoundsController < ApplicationController
  before_action :doorkeeper_authorize!
  after_action :verify_authorized

  def create
    tournament = pundit_user.organised_tournaments.find(params[:tournament_id])
    model = tournament.rounds.new
    authorize model
    form = RoundForm.new(model)
    if form.validate(permitted_attributes(model))
      form.save
      return render json: form.model,
                    status: :created
    end
    render_validation_errors(form)
  end

  def update
    model = pundit_user.tournament_rounds.find(params[:id])
    authorize model
    form = RoundForm.new(model)
    if form.validate(permitted_attributes(model))
      form.save
      return render json: form.model
    end
    render_validation_errors(form)
  end

  def destroy
    model = pundit_user.tournament_rounds.find(params[:id])
    authorize model
    model.destroy!
    head :no_content
  end
end

class CompetitorsController < ApplicationController
  before_action :doorkeeper_authorize!
  after_action :verify_authorized

  # Actions for potential tournament participants

  def create
    tournament = Tournament.find(params[:tournament_id])
    competitor = current_user.competitors.find_or_initialize_by(tournament: tournament)
    authorize competitor
    form = CompetitorForm.new(competitor)
    if form.validate(permitted_attributes(competitor))
      form.save
      return render json: form.model,
                    status: :created
    end
    render_validation_errors(form)
  end

  def destroy
    competitor = current_user.competitors.find_by!(tournament_id: params[:tournament_id])
    authorize competitor
    competitor.destroy!
    head :no_content
  end

  # Actions for tournament organiser

  def confirm
    competitor = current_user.tournament_competitors.find(params[:id])
    authorize competitor
    competitor.update!(status: :confirmed)
    render json: competitor
  end
end

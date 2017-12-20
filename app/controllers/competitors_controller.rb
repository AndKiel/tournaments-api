class CompetitorsController < ApplicationController
  before_action :doorkeeper_authorize!
  after_action :verify_authorized

  def create
    tournament = Tournament.find(params[:tournament_id])
    competitor = pundit_user.competitors.find_or_initialize_by(tournament: tournament)
    authorize competitor
    competitor.save!
    head :created
  end

  def destroy
    competitor = pundit_user.competitors.find_by!(tournament_id: params[:tournament_id])
    authorize competitor
    competitor.destroy!
    head :no_content
  end

  def confirm
    competitor = pundit_user.tournament_competitors.find(params[:id])
    authorize competitor
    competitor.update!(status: :confirmed)
    head :no_content
  end
end

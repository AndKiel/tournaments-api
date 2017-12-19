class CompetitorsController < ApplicationController
  before_action :doorkeeper_authorize!
  after_action :verify_authorized

  def create
    model = pundit_user.competitors.new(tournament_id: params[:tournament_id])
    authorize model
    model.save!
    head :no_content
  end

  def destroy
    model = pundit_user.competitors.find_by!(tournament_id: params[:tournament_id])
    authorize model
    model.destroy!
    head :no_content
  end

  def confirm
    model = pundit_user.tournament_competitors.find(params[:id])
    authorize model
    model.update(status: :confirmed)
    head :no_content
  end
end

class ResultsController < ApplicationController
  after_action :verify_authorized

  def index
    tournament = Tournament.find(params[:tournament_id])
    authorize tournament
    render json: tournament.results
  end
end

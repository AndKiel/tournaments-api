# frozen_string_literal: true

class ResultsController < ApplicationController
  after_action :verify_authorized

  def index
    tournament = Tournament.find(params[:tournament_id])
    authorize tournament, :results?
    render json: ResultSerializer.render(tournament.results, root: :results)
  end
end

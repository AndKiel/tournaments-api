# frozen_string_literal: true

class TournamentsController < ApplicationController
  before_action :doorkeeper_authorize!, only: %i[enlisted create update destroy start end]
  after_action :verify_authorized
  after_action :verify_policy_scoped, only: %i[create update destroy start end]

  # Public actions

  def index
    authorize Tournament
    tournaments = policy_scope(Tournament)
                    .apply_filters(params)
                    .order(starts_at: :asc)
                    .page(params[:page])
    render json: TournamentSerializer.render(tournaments, root: :tournaments, meta: pagination_meta(tournaments))
  end

  def enlisted
    authorize Tournament
    tournaments = current_user.tournaments
                    .apply_filters(params)
                    .order(starts_at: :asc)
                    .page(params[:page])
    render json: TournamentSerializer.render(tournaments, root: :tournaments, meta: pagination_meta(tournaments))
  end

  def show
    tournament = Tournament.includes(:competitors, rounds: :players).find(params[:id])
    authorize tournament
    render json: TournamentSerializer.render(tournament, root: :tournament, view: :extended)
  end

  # Actions for authenticated users

  def create
    tournament = policy_scope(Tournament).new
    authorize tournament
    contract = Tournament::CreateContract.new
    validation_result = contract.call(permitted_attributes(tournament))
    if validation_result.success?
      tournament.update!(validation_result.to_h)
      return render json: TournamentSerializer.render(tournament, root: :tournament),
                    status: :created
    end
    render_validation_errors(validation_result)
  end

  # Actions for tournament organisers

  def update
    tournament = policy_scope(Tournament).find(params[:id])
    authorize tournament
    contract = Tournament::UpdateContract.new
    validation_result = contract.call(permitted_attributes(tournament))
    if validation_result
      tournament.update!(validation_result.to_h)
      return render json: TournamentSerializer.render(tournament, root: :tournament)
    end
    render_validation_errors(validation_result)
  end

  def destroy
    tournament = policy_scope(Tournament).find(params[:id])
    authorize tournament
    tournament.destroy!
    head :no_content
  end

  def start
    tournament = policy_scope(Tournament).find(params[:id])
    authorize tournament
    tournament.update!(status: :in_progress)
    render json: TournamentSerializer.render(tournament, root: :tournament)
  end

  def end
    tournament = policy_scope(Tournament).find(params[:id])
    authorize tournament
    tournament.update!(status: :ended)
    render json: TournamentSerializer.render(tournament, root: :tournament)
  end
end

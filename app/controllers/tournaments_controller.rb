class TournamentsController < ApplicationController
  include TournamentsDoc

  after_action :verify_authorized


  def index
    authorize Tournament
    models = policy_scope(Tournament).page(params[:page])
    render json: models
  end

  def show
    model = Tournament.find(params[:id])
    authorize model
    render json: model
  end


  before_action :doorkeeper_authorize!, only: %i[create update destroy start end]
  after_action :verify_policy_scoped, only: %i[create update destroy start end]

  def create
    model = policy_scope(Tournament).new
    authorize model
    form = TournamentForm.new(model)
    if form.validate(permitted_attributes(model))
      form.save
      return render json: form.model,
                    status: :created
    end
    render_validation_errors(form)
  end

  def update
    model = policy_scope(Tournament).find(params[:id])
    authorize model
    form = TournamentForm.new(model)
    if form.validate(permitted_attributes(model))
      form.save
      return render json: form.model
    end
    render_validation_errors(form)
  end

  def destroy
    model = policy_scope(Tournament).find(params[:id])
    authorize model
    model.destroy!
    head :no_content
  end

  def start
    model = policy_scope(Tournament).find(params[:id])
    authorize model
    model.update!(status: :in_progress)
    render json: model
  end

  def end
    model = policy_scope(Tournament).find(params[:id])
    authorize model
    model.update!(status: :ended)
    render json: model
  end
end

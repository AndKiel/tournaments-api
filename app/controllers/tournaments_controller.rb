class TournamentsController < ApplicationController
  include TournamentsDoc

  after_action :verify_authorized


  def index
    authorize Tournament
    models = Tournament.page(params[:page])
    render json: models
  end

  def show
    model = Tournament.find(params[:id])
    authorize model
    render json: model
  end


  before_action :doorkeeper_authorize!, only: %i[create update destroy]
  after_action :verify_policy_scoped, only: %i[create update destroy]

  def create
    model = policy_scope(Tournament).new
    authorize model
    form = Tournament::Form.new(model)
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
    form = Tournament::Form.new(model)
    if form.validate(permitted_attributes(model))
      form.save
      return render json: form.model
    end
    render_validation_errors(form)
  end

  def destroy
    model = policy_scope(Tournament).find(params[:id])
    authorize model
    model.destroy
    head :no_content
  end
end

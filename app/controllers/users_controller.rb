class UsersController < ApplicationController
  include UsersDoc

  after_action :verify_authorized

  def sign_up
    model = User.new
    authorize model
    form = User::SignUp.new(model)
    if form.validate(permitted_attributes(model))
      form.password_digest = BCrypt::Password.create(form.password)
      form.save
      return render json: form.model,
                    status: :created
    end
    render_validation_errors(form)
  end


  before_action :doorkeeper_authorize!, only: %i[show update]

  def show
    model = pundit_user
    authorize model
    render json: pundit_user
  end

  def update
    model = pundit_user
    authorize model
    form = User::Update.new(model)
    if form.validate(permitted_attributes(model))
      form.password_digest = BCrypt::Password.create(form.password) if form.password.present?
      form.save
      return render json: form.model
    end
    render_validation_errors(form)
  end
end

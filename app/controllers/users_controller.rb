class UsersController < ApplicationController
  before_action :doorkeeper_authorize!, only: %i[show update]
  after_action :verify_authorized

  # Public actions

  def sign_up
    user = User.new
    authorize user
    form = User::SignUpForm.new(user)
    if form.validate(permitted_attributes(user))
      form.save
      return render json: form.model,
                    status: :created
    end
    render_validation_errors(form)
  end

  # Actions for authenticated users

  def show
    user = current_user
    authorize user
    render json: current_user
  end

  def update
    user = current_user
    authorize user
    form = User::UpdateForm.new(user)
    if form.validate(permitted_attributes(user))
      form.save
      return render json: form.model
    end
    render_validation_errors(form)
  end
end

class UsersController < ApplicationController
  include UsersDoc

  after_action :verify_authorized


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


  before_action :doorkeeper_authorize!, only: %i[show update]

  def show
    user = pundit_user
    authorize user
    render json: pundit_user
  end

  def update
    user = pundit_user
    authorize user
    form = User::UpdateForm.new(user)
    if form.validate(permitted_attributes(user))
      form.save
      return render json: form.model
    end
    render_validation_errors(form)
  end
end

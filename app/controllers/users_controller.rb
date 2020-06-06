# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :doorkeeper_authorize!, only: %i[show update]
  after_action :verify_authorized

  # Public actions

  def sign_up
    user = User.new
    authorize user
    contract = User::SignUpContract.new
    validation_result = contract.call(permitted_attributes(user).to_h)
    if validation_result.success?
      attributes = validation_result.to_h
      attributes.delete(:password_confirmation)
      user.update!(attributes)
      return render json: UserSerializer.render(user, root: :user),
                    status: :created
    end
    render_validation_errors(validation_result)
  end

  # Actions for authenticated users

  def show
    user = current_user
    authorize user
    render json: UserSerializer.render(current_user, root: :user)
  end

  def update
    user = current_user
    authorize user
    contract = User::UpdateContract.new(model: user)
    validation_result = contract.call(permitted_attributes(user).to_h)
    if validation_result.success?
      attributes = validation_result.to_h
      attributes.delete(:password_confirmation)
      user.update!(attributes)
      return render json: UserSerializer.render(user, root: :user)
    end
    render_validation_errors(validation_result)
  end
end

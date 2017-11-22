class UsersController < ApplicationController
  after_action :verify_authorized
  after_action :verify_policy_scoped

  def sign_up
    model = policy_scope(User).new
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
end

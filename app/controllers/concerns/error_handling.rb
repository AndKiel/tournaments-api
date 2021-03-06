# frozen_string_literal: true

module ErrorHandling
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from InvalidParamsError,           with: :invalid_params
    rescue_from Pundit::NotAuthorizedError,   with: :action_forbidden

    def record_not_found
      head :not_found
    end

    def action_forbidden(exception)
      policy_name = exception.policy.class.to_s.underscore
      message     = I18n.t "#{policy_name}.#{exception.query}", scope: 'pundit', default: :default

      render json: { error: 'forbidden', error_description: message },
             status: :forbidden
    end

    def invalid_params(exception)
      render json: { error: 'invalid_params', error_description: exception.message, fields: exception.errors },
             status: :unprocessable_entity
    end

    protected

    def doorkeeper_unauthorized_render_options(_error)
      {
        nothing: true,
        status: :unauthorized
      }
    end
  end
end

class ApplicationController < ActionController::API
  include Pundit

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from Pundit::NotAuthorizedError,   with: :action_forbidden

  def record_not_found
    head :not_found
  end

  def action_forbidden(exception)
    policy_name = exception.policy.class.to_s.underscore
    message     = I18n.t "#{policy_name}.#{exception.query}", scope: 'pundit', default: :default

    render_error_json(message, 'unauthorized', :forbidden)
  end

  def render_error_json(detail, title, status = :unprocessable_entity)
    render json: { errors: [{ detail: detail, title: title }] },
           status: status
  end

  def render_validation_errors(form)
    render json: form,
           serializer: ActiveModel::Serializer::ErrorSerializer,
           status: :unprocessable_entity
  end

  def ping
    head :ok
  end

  protected

  def pundit_user
    # return unless doorkeeper_token
    # @pundit_user ||= User.find_by(id: doorkeeper_token.resource_owner_id)
  end

  def doorkeeper_unauthorized_render_options(_error)
    {
      nothing: true,
      status: :unauthorized
    }
  end
end

module Authentication
  extend ActiveSupport::Concern

  included do
    include Pundit

    protected

    def pundit_user
      return unless doorkeeper_token
      @pundit_user ||= User.find_by(id: doorkeeper_token.resource_owner_id)
    end
  end
end

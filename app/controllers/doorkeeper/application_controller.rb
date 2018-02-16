# HACK: doorkeeper does not support Rails API at this moment
# For it to work it is necessary to:
# - disable protect_from_forgery
# - override layout (used by Doorkeeper::ApplicationsController)
module Doorkeeper
  class ApplicationController < Doorkeeper.configuration.base_controller.constantize
    # include Helpers::Controller
    include Internationalization

    # protect_from_forgery with: :exception
    # helper 'doorkeeper/dashboard'

    def self.layout(*); end
  end
end

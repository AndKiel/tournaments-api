# HACK: doorkeeper does not support Rails API at this moment
# It is necessary to remove protect_from_forgery so it can work in production
module Doorkeeper
  class ApplicationController < Doorkeeper.configuration.base_controller.constantize
    include Helpers::Controller

    # protect_from_forgery with: :exception
    # helper 'doorkeeper/dashboard'
  end
end

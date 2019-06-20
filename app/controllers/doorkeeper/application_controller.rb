# frozen_string_literal: true

module Doorkeeper
  class ApplicationController < Doorkeeper.configuration.base_controller.constantize
    include Internationalization
  end
end

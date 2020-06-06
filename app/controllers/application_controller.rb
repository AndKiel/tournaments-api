# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Authentication
  include ErrorHandling
  include Internationalization
  include Meta
  include Validation
end

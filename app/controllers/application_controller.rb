class ApplicationController < ActionController::API
  include Authentication
  include ErrorHandling
  include Internationalization
  include Meta
end

class ApplicationController < ActionController::API
  include Authentication
  include ErrorHandling
  include Meta
end

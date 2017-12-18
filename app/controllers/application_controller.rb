class ApplicationController < ActionController::API
  include Authentication
  include ErrorHandling

  def ping
    head :ok
  end
end

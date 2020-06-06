# frozen_string_literal: true

class ApiError < StandardError
  def initialize(msg = nil)
    super(msg)
  end
end

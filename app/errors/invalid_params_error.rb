# frozen_string_literal: true

class InvalidParamsError < ApiError
  attr_reader :errors

  def initialize(validation_result:)
    @errors = validation_result.errors.to_h
    super('Invalid request params.')
  end
end

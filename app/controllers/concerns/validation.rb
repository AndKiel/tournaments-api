# frozen_string_literal: true

module Validation
  extend ActiveSupport::Concern

  included do
    def validate(contract, model)
      validation_result = contract.call(params_hash(model))
      return yield validation_result if validation_result.success?

      raise InvalidParamsError.new(validation_result: validation_result)
    end

    def params_hash(model)
      permitted_attributes(model).to_h
    end
  end
end

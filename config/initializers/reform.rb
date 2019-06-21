# frozen_string_literal: true

require 'reform/form/active_model/validations'
require 'reform/form/validation/unique_validator'

Reform::Form.class_eval do
  # TODO: switch to dry-validation?
  feature Reform::Form::ActiveModel::Validations
end

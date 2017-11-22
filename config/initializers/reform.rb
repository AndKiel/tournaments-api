require 'reform/form/active_model/validations'
require 'reform/form/validation/unique_validator'

Reform::Form.class_eval do
  feature Reform::Form::ActiveModel::Validations
end

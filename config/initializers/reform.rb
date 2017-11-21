require 'reform/form/dry'

Rails.application.config.reform.validations = :dry

Reform::Form.class_eval do
  feature Reform::Form::Dry
end

# frozen_string_literal: true

require 'simplecov_setup'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
# Prevent database truncation if the environment is production
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!
require 'json_expressions/rspec'
# require 'webmock/rspec'

require 'support/controller_macros'
require 'support/database_cleaner'
require 'support/factory_bot'
require 'support/json_matchers'
require 'support/json_helpers'
require 'support/request_macros'

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.extend ControllerMacros, type: :controller
  config.extend RequestMacros, type: :request
  config.include JsonHelpers

  config.filter_rails_from_backtrace!
  config.infer_spec_type_from_file_location!
end

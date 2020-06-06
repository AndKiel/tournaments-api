# frozen_string_literal: true

require 'spec_helper'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'

ActiveRecord::Migration.maintain_test_schema!

# Add additional requires below this line. Rails is not loaded until this point!
require 'support/controller_macros'
require 'support/database_cleaner'
require 'support/factory_bot'
require 'support/json_matchers'
require 'support/request_macros'

RSpec.configure do |config|
  config.extend ControllerMacros, type: :controller
  config.extend RequestMacros, type: :request

  config.filter_rails_from_backtrace!
  config.infer_spec_type_from_file_location!
end

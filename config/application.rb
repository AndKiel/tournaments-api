# frozen_string_literal: true

require_relative 'boot'

require 'rails'
require 'active_record/railtie'
require 'action_controller/railtie'

Bundler.require(*Rails.groups)

module TournamentsApi
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    secrets.secret_key_base = Figaro.env.secret_key_base!

    config.action_controller.allow_forgery_protection = !Rails.env.test?
    config.action_controller.perform_caching = Rails.env.production?
    config.action_view.raise_on_missing_translations = !Rails.env.production?
    config.active_record.dump_schema_after_migration = Rails.env.development?
    config.api_only = true
    config.cache_classes = Rails.env.production?
    config.consider_all_requests_local = !Rails.env.production?
    config.eager_load = Rails.env.production?

    config.generators do |g|
      g.orm :active_record, primary_key_type: :uuid
    end
  end
end

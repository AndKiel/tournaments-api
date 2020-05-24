# frozen_string_literal: true

Rails.application.configure do
  config.action_dispatch.show_exceptions = false
  config.active_support.deprecation = :stderr
  config.cache_store = :null_store
  config.public_file_server.enabled = true
  config.public_file_server.headers = {
    'Cache-Control' => "public, max-age=#{1.hour.to_i}"
  }

  config.after_initialize do
    Bullet.enable = true
    Bullet.raise = true
  end
end

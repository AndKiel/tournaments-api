# frozen_string_literal: true

Rails.application.configure do
  config.active_record.migration_error = :page_load
  config.active_record.verbose_query_logs = true
  config.active_support.deprecation = :log
  config.cache_store = :null_store
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker
end

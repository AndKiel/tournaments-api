# frozen_string_literal: true

max_threads_count = Integer(ENV.fetch('RAILS_MAX_THREADS') { 5 })
min_threads_count = Integer(ENV.fetch('RAILS_MIN_THREADS') { max_threads_count })
threads min_threads_count, max_threads_count

environment ENV.fetch('RAILS_ENV') { 'development' }
port        Integer(ENV.fetch('PORT') { 3000 })
workers     Integer(ENV.fetch('WEB_CONCURRENCY') { 2 })

pidfile ENV.fetch('PIDFILE') { 'tmp/pids/server.pid' }

preload_app!

before_fork do
  ActiveRecord::Base.connection_pool.disconnect!
end

on_worker_boot do
  ActiveRecord::Base.establish_connection
end

# Allow puma to be restarted by `rails restart` command.
plugin :tmp_restart

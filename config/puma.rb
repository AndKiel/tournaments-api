threads_count = Integer(ENV.fetch('RAILS_MAX_THREADS', 5))
threads threads_count, threads_count

environment ENV.fetch('RAILS_ENV', 'development')
port        Integer(ENV.fetch('PORT', 3000))
workers     Integer(ENV.fetch('WEB_CONCURRENCY', 2))

preload_app!

before_fork do
  ActiveRecord::Base.connection_pool.disconnect!
end

on_worker_boot do
  ActiveRecord::Base.establish_connection
end

# Allow puma to be restarted by `rails restart` command.
plugin :tmp_restart

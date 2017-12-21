require 'simplecov'

SimpleCov.start do
  load_profile 'test_frameworks'

  add_filter %r{^/app/docs/}
  add_filter %r{^/config/}
  add_filter %r{^/db/}

  add_group 'Controllers', 'app/controllers'
  add_group 'Forms',       'app/forms'
  add_group 'Models',      'app/models'
  add_group 'Policies',    'app/policies'
  add_group 'Serializers', 'app/serializers'
  add_group 'Services',    'app/services'
  # add_group 'Uploaders',   'app/uploaders'

  track_files '{app,lib}/**/*.rb'
end

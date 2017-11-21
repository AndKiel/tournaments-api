require 'simplecov'

SimpleCov.start 'rails' do
  add_group 'Forms',       'app/forms'
  add_group 'Policies',    'app/policies'
  add_group 'Serializers', 'app/serializers'
  # add_group 'Services',    'app/services'
  # add_group 'Uploaders',   'app/uploaders'
end

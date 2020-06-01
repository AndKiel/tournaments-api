# frozen_string_literal: true

source 'https://rubygems.org'
ruby '2.7.1'

# Base
gem 'bootsnap', require: false
gem 'figaro' # TODO: Maybe replace with dotenv
gem 'pg'
gem 'puma'
gem 'rack-cors'
gem 'rails', '~> 6.0.3'

# Debugging
gem 'pry-byebug'
gem 'pry-rails'

# Users, authentication, authorization
gem 'bcrypt'
gem 'doorkeeper', '~> 5.3.0'
gem 'doorkeeper-i18n'
gem 'pundit'

# Validations
gem 'dry-monads' # TODO: Remove when dry-validation 1.5.1 is released
gem 'dry-validation'
gem 'reform'
gem 'validates_email_format_of'

# File upload and processing
# gem 'shrine'
# gem 'shrine-reform'
# gem 'image_processing'
# gem 'mini_magick'

# JSON and utilities
gem 'blueprinter'
gem 'kaminari'
gem 'oj'
gem 'scenic'

group :development do
  gem 'annotate'
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false

  # Optimization
  # gem 'derailed_benchmarks'
  # gem 'flamegraph'
  # gem 'rack-mini-profiler'
end

group :test do
  gem 'bullet'
  gem 'codecov', require: false
  gem 'database_cleaner-active_record'
  gem 'factory_bot_rails'
  gem 'fuubar'
  gem 'json_matchers'
  gem 'rspec-rails'
  gem 'simplecov', require: false
end

# frozen_string_literal: true

source 'https://rubygems.org'
ruby '2.7.1'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end


# Base
gem 'bootsnap', '>= 1.1.0', require: false
gem 'figaro'
gem 'pg'
gem 'puma'
gem 'rack-cors'
gem 'rails', '~> 6.0.0'


# Debugging
gem 'pry-byebug'
gem 'pry-rails'


# Users, authentication, authorization
gem 'bcrypt'
gem 'doorkeeper', '~> 5.3.0'
gem 'doorkeeper-i18n'
gem 'pundit'


# Validations
gem 'reform', '~> 2.2.0'
gem 'reform-rails'
gem 'validates_email_format_of'
gem 'validates_timeliness'


# File upload and processing
# gem 'shrine'
# gem 'shrine-reform'
# gem 'image_processing'
# gem 'mini_magick'


# JSON and utilities
gem 'blueprinter'
gem 'enumerize'
gem 'kaminari'
gem 'oj'
gem 'scenic'


group :development do
  # Auto-reloading
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen'

  gem 'annotate'
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false

  # Optimization
  # gem 'derailed_benchmarks'
  # gem 'flamegraph'
  # gem 'rack-mini-profiler'
end


group :test do
  gem 'bullet'
  gem 'codecov', require: false
  gem 'fuubar'
  gem 'json_expressions', require: false
  gem 'rspec-rails'
  gem 'simplecov', require: false
  gem 'webmock'
end

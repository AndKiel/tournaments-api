# frozen_string_literal: true

Spring.watch(
  '.ruby-version',
  '.rbenv-vars',
  'config/application.yml',
  'tmp/restart.txt',
  'tmp/caching-dev.txt'
)

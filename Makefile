setup:
	make stop
	make build
	make services
	make install
	docker-compose run --rm web "bundle exec rake db:setup"

stop:
	docker-compose stop

build:
	docker-compose build

services:
	docker-compose up -d db

install:
	docker-compose run --rm web "bundle install"

migrate:
	docker-compose run --rm web "bundle exec rake db:migrate"

start:
	docker-compose up web

test:
	docker-compose run --rm web "bundle exec rspec"

annotate:
	docker-compose run --rm web "bundle exec annotate"

documentation:
	docker-compose run --rm docs

schema:
	docker-compose run --rm schema

down:
	docker-compose down

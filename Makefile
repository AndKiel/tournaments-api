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
	docker-compsoe up -d db

install:
	docker-compose run --rm web "bundle install"

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

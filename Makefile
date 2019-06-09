setup:
	make stop
	docker-compose build
	docker-compose up -d db
	docker-compose run --rm web "bundle install && bundle exec rake db:setup"

stop:
	docker-compose stop

start:
	docker-compose up web

test:
	docker-compose run --rm web "bundle exec rspec"

documentation:
	docker-compose run --rm docs

schema:
	docker-compose run --rm schema

# Tournaments API #

Back-end for tournament management application.

Documentation is available [here](https://andkiel.github.io/tournaments-api/index.html).

### Setup ###

First Docker build: `docker-compose build`.

Launch stack: `docker-compose up web`.

Create database: `docker-compose run web bundle exec rake db:setup`.

API will be available at [http://localhost:3000/]().

Front-end is available [here](https://github.com/AndKiel/tournaments-api-ui).

### Running Tests ###

Execute `docker-compose run web bundle exec rspec`.

### Updating documentation ###

API documentation: `docker-compose run docs`.

Database schema: `docker-compose run schema`.

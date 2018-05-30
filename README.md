# Tournaments API #

[![Build Status](https://travis-ci.com/AndKiel/tournaments-api.svg?branch=master)](https://travis-ci.com/AndKiel/tournaments-api)
[![codecov](https://codecov.io/gh/AndKiel/tournaments-api/branch/master/graph/badge.svg)](https://codecov.io/gh/AndKiel/tournaments-api)

Back-end for tournament management application.

Documentation for API endpoints is available [here](https://andkiel.github.io/tournaments-api/index.html).

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

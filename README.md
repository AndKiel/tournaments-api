# Tournaments API #

[![Build Status](https://travis-ci.com/AndKiel/tournaments-api.svg?branch=master)](https://travis-ci.com/AndKiel/tournaments-api)
[![codecov](https://codecov.io/gh/AndKiel/tournaments-api/branch/master/graph/badge.svg)](https://codecov.io/gh/AndKiel/tournaments-api)

The back-end for tournament management application.

Documentation for API endpoints is available [here](https://andkiel.github.io/tournaments-api/index.html).

### Prerequisites ###

- [Docker](https://www.docker.com/products/docker-desktop)

### Setup ###

Run `make setup`,

then launch the app via `make start`.

API will be available at [http://localhost:3000/]().

Front-end is available [here](https://github.com/AndKiel/tournaments-api-ui).

### Running Tests ###

To run the tests, use the following command: `make test`.

### Updating documentation ###

API documentation: `make documentation`.

Database schema: `make schema`.

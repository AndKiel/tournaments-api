# Tournaments API #

Back-end for tournament management application.

Documentation is available [here](https://andkiel.github.io/tournaments-api/index.html).

### Setup ###

First Docker build: `docker-compose build`.

Launch stack: `docker-compose up web`.

Create database: `docker-compose run web bundle exec rake db:setup`.

API will be available at [http://localhost:3000/]().

### Running Tests ###

Execute `docker-compose run web bundle exec rspec`.

### Generating docs ###

Execute `docker-compose run docs`.

### Generating database schema ###

Prerequisites:
* [schemacrawler](http://www.schemacrawler.com/) (14.16.03+)
* [graphviz](https://graphviz.gitlab.io)

While Docker web container is running execute `./schemacrawler.sh -infolevel=standard -command=schema -sortcolumns -portablenames -outputformat=pdf -outputfile=db-schema.pdf -server=postgresql -u=postgres -password=postgres -database="tournaments-api-development"`.

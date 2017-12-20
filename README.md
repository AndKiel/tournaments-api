# Untitled Tournaments API #

Back-end for tournament management application.

### Setup ###

First Docker build: `docker-compose build`.

Launch stack: `docker-compose up`.

Create database: `docker-compose run web bundle exec rake db:setup`.

### Running Tests ###

Execute `docker-compose run web bundle exec rspec`.

### Generating database schema ###

Requires schemacrawler (14.16.03) and graphviz.

Execute `./schemacrawler.sh -infolevel=standard -command=schema -sortcolumns -portablenames -outputformat=pdf -outputfile=db-schema.pdf -server=postgresql -u=postgres -password=postgres -database="untitled-tournaments-development"`

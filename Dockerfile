FROM ruby:2.4.2
RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev nodejs

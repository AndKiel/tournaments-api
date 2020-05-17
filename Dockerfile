FROM ruby:2.7.1-slim
RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev
RUN gem install bundler

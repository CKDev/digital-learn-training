#!/bin/bash

set -e

gem install bundler -v '~> 2.5.23'

if [ "$RAILS_ENV" = "development" ]
then
  bundle config unset without
  # bundle binstubs bundler --force
  bundle install
else
  bundle config set without "development test"
  # bundle binstubs bundler --force
  bundle install --quiet --jobs 3 --retry 3
fi

exec "$@"

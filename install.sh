#!/bin/bash

set -e

gem install bundler

if [ "$RAILS_ENV" = "development" ]
then
  bundle config unset without
  bundle install
else
  bundle config set without "development test"
  bundle install --quiet --jobs 3 --retry 3

  rm -rf /app/public/assets/
  bundle exec rake assets:precompile
fi

exec "$@"

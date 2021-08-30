FROM ruby:2.7.4-slim-buster

# install rails dependencies
RUN apt-get clean all && \
  apt-get update -qq && \
  apt-get install -y \
  build-essential \
  libpq-dev \
  curl \
  gnupg2 \
  apt-utils \
  default-libmysqlclient-dev \
  git \
  libcurl3-dev \
  cmake \
  libssl-dev \
  pkg-config \
  openssl \
  imagemagick \
  file \
  nodejs \
  yarn

RUN mkdir /rails-app
WORKDIR /rails-app

# Adding gems
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN gem install bundler && \
  bundle install --jobs 3 --retry 3

COPY . /rails-app

ARG RAILS_ENV

# Precompile assets
RUN rm -rf /app/public/assets/
RUN RAILS_ENV=${RAILS_ENV} bundle exec rake assets:precompile

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
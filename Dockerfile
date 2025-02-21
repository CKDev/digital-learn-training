FROM ruby:3.2.6-slim-bookworm

# install rails dependencies
RUN apt-get update -qq && \
  apt-get install -y --no-install-recommends \
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
  npm \
  vim && \
  rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /rails-app

# Consume build args
ARG RAILS_ENV
ARG RAILS_MASTER_KEY

# Add gems
COPY Gemfile Gemfile.lock ./

# Install gems
COPY install_gems.sh ./
RUN chmod u+x install_gems.sh && ./install_gems.sh

# Install Node.js dependencies
COPY package.json package-lock.json ./
RUN npm install

COPY . .

# Precompile assets (includes vite build via vite_rails gem)
COPY precompile_assets.sh ./
RUN chmod u+x precompile_assets.sh && ./precompile_assets.sh

# Add entrypoint script
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
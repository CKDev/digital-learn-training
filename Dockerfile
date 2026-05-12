FROM ruby:3.2.9-slim-bookworm

# install rails dependencies
RUN apt-get update -qq && \
  apt-get install -y --no-install-recommends \
  build-essential \
  libpq-dev \
  libyaml-dev \
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
  vim && \
  rm -rf /var/lib/apt/lists/*

# Install Node.js 22 LTS directly from the official image (avoids NodeSource network dependency)
COPY --from=node:22-bookworm-slim /usr/local/bin/node /usr/local/bin/node
COPY --from=node:22-bookworm-slim /usr/local/lib/node_modules /usr/local/lib/node_modules
RUN ln -sf /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm && \
  ln -sf /usr/local/lib/node_modules/npm/bin/npx-cli.js /usr/local/bin/npx && \
  npm install -g npm@11

# Set working directory
WORKDIR /rails-app

# Build args (injected from CodeBuild)
ARG RAILS_ENV
ARG RAILS_MASTER_KEY
ARG ROLLBAR_ENV

# Set ENV so Rails sees them during asset precompile
ENV RAILS_ENV=${RAILS_ENV}
ENV RAILS_MASTER_KEY=${RAILS_MASTER_KEY}
ENV ROLLBAR_ENV=${ROLLBAR_ENV}

# Install gems
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

COPY install_gems.sh install_gems.sh
RUN chmod u+x install_gems.sh && ./install_gems.sh

# Install Node.js dependencies
COPY package.json package-lock.json ./
RUN npm install

# Copy app code
COPY . /rails-app

# Precompile assets (this will load Rails & credentials)
COPY precompile_assets.sh precompile_assets.sh
RUN chmod u+x precompile_assets.sh && ./precompile_assets.sh

# Entrypoint
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
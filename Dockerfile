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

# Install Node.js 22 via NodeSource (GPG key method — setup_22.x|bash can silently fall back to Node 18)
RUN mkdir -p /etc/apt/keyrings && \
  curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg && \
  echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_22.x nodistro main" > /etc/apt/sources.list.d/nodesource.list && \
  apt-get update -qq && \
  apt-get install -y --no-install-recommends nodejs && \
  rm -rf /var/lib/apt/lists/*

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
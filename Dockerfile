ARG RUBY_VERSION=3.2.1
FROM ruby:$RUBY_VERSION

# Install packages need to build gems
RUN apt-get update -qq && \
    apt-get install -y build-essential libvips bash bash-completion libffi-dev tzdata postgresql nodejs npm yarn && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man

# Rails app lives here
WORKDIR /app

# Set production environment
ENV RAILS_LOG_TO_STDOUT="1" \
    RAILS_SERVE_STATIC_FILES="true" \
    RAILS_ENV="production" \
    BUNDLE_WITHOUT="test development" \
    POSTGRES_HOST=${POSTGRES_HOST} \
    POSTGRES_DB=${POSTGRES_DB} \
    POSTGRES_USER=${POSTGRES_USER} \
    POSTGRES_PASSWORD=${POSTGRES_PASSWORD} \
    RAILS_ENV=${RAILS_ENV} \
    REDIS_URL=${REDIS_URL}

# Install application gems
COPY Gemfile Gemfile.lock /app/
RUN bundle install

# Copy application code
COPY . /app/

# Precompile bootsnap code for faster boot times
RUN bundle exec bootsnap precompile --gemfile app/ lib/

RUN echo "production:\n  secret_key_base: $(bundle exec rake secret)" > /app/config/secrets.yml

# Precompiling assets for production without requiring secret RAILS_MASTER_KEY
RUN bundle exec rails assets:precompile

# Start the server by default, this can be overwritten at runtime
EXPOSE 3000:3000
CMD ["./bin/rails", "server"]

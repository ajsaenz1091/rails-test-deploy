ARG RUBY_VERSION=3.1.3
FROM ruby:${RUBY_VERSION}

RUN apt-get update -qq && \
    apt-get install -y vim sqlite3 yarn nodejs build essential libvips && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists* /usr/share/doc /usr/share/man

WORKDIR /app

ENV RAILS_ENV="production" \
    RAILS_SERVE_STATIC_FILES="true" \
    RAILS_LOG_TO_STDOUT="1" \
    BUNDLE_WITHOUT="development"

COPY Gemfile Gemfile.lock ./

RUN bundle config --global frozen 1
RUN bundle install --without development test

COPY . .

RUN bundle exec bootsnap precompile --gemfile app/ lib/

EXPOSE 3000 

CMD ["rails", "s", "-b", "0.0.0.0"]
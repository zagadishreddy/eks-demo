FROM ruby:2.5.1

LABEL maintainer="bran@feedmob.com"

ENV APP_PATH /app

# Install basic dependencies
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash
RUN apt-get update -qq && apt-get install -y --no-install-recommends apt-utils build-essential libpq-dev nodejs
RUN npm install -g yarn
RUN mkdir $APP_PATH

WORKDIR $APP_PATH

COPY Gemfile /$APP_PATH/Gemfile
COPY Gemfile.lock /$APP_PATH/Gemfile.lock

# Install gemfiles
RUN bundle install

# Bundle app source code
COPY . .

# Asset precompile
RUN bundle exec rake assets:precompile

CMD ["bundle", "exec", "rails", "s"]

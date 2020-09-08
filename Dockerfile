FROM ruby:2.7.1-alpine as builder

RUN apk add --update --no-cache bash build-base nodejs sqlite-dev tzdata postgresql-dev yarn

RUN gem install bundler:2.1.4

WORKDIR /usr/src/docker_rails

COPY Gemfile* ./
RUN bundle install 

COPY package.json yarn.lock ./
RUN yarn install --check-files

COPY . .

# Add a script to be executed every time the container starts.

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

CMD ["bin/rails", "s", "-b", "0.0.0.0"]
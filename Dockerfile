# use the official Ruby image.
# https://hub.docker.com/_/ruby
FROM ruby:3.2-buster

# Install production dependencies.
WORKDIR /usr/src/app
COPY Gemfile Gemfile.lock ./
ENV BUNDLE_FROZEN=true
RUN gem update --system 3.2.3 && gem install bundler && bundle config set --local without 'test'

# Copy local code to the container image.
COPY . ./
RUN bundle install

ENV PORT=80
# Run the web service on container startup.
CMD ["ruby", "./app.rb"]

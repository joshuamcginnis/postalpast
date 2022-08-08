FROM ruby:3.1.2
RUN apt-get update && apt-get upgrade -y

WORKDIR /app

# copy gemfile for caching
COPY Gemfile /app
COPY Gemfile.lock /app

# install gems
RUN bundle config set --local without 'test development'
RUN bundle install

COPY . /app

# run options
ENTRYPOINT ["./bin/entrypoint.sh"]
RUN chmod +x ./bin/entrypoint.sh
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]

FROM ruby:3.1.2
RUN apt-get update && apt-get upgrade -y

WORKDIR /app

RUN gem install -N bundler
COPY . .
RUN bundle config set --local without 'test development'
RUN bundle install
CMD ["rails"]
EXPOSE 3000

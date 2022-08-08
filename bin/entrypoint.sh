#!/bin/bash

if [ "$1" = 'rails' ]; then
  exec bundle exec rails server

elif [ "$1" = 'sidekiq' ]; then
  exec bundle exec sidekiq -c 1 -v

elif [ "$1" = 'db_migrate' ]; then
  exec bundle exec rake db:migrate

else
  exec $@
fi

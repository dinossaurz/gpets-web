#!/bin/bash

rm -f /gpets-web/tmp/pids/server.pid
bundle exec rake db:migrate
exec "$@"

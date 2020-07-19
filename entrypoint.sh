#!/bin/bash

rm -f /gpets-web/tmp/pids/server.pid
exec "$@"

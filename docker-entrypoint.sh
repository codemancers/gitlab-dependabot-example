#!/bin/sh
set -e

if ! [ bundle check ] ; then
    bundle install;
fi

rm -f /app/tmp/pids/server.pid

exec "$@"
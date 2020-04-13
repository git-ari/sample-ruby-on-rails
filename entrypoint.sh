#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /myapp/tmp/pids/server.pid
rm -f /usr/local/var/postgres/postmaster.pid
rm -f /var/run/postgresql/.s.PGSQL.5432

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
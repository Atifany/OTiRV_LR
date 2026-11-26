#!/usr/bin/env bash
set -e

export PGHOST=/var/run/postgresql

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

psql -U postgres -d postgres -tAc "SELECT 1 FROM pg_database WHERE datname='orders_db'" | grep -q 1 || \
  psql -U postgres -d postgres -c "CREATE DATABASE orders_db"

psql -U postgres -d orders_db -f "$SCRIPT_DIR/init.sql"

echo "Init scripts applied successfully."
#!/bin/bash
set -e

# Аналог docker_create_db_directories из официального postgres-образа.
# Запускается от root, поэтому может исправить права на томе.
mkdir -p "$PGDATA"
chmod 0700 "$PGDATA" || :
mkdir -p /run/postgresql || :
chmod 03775 /run/postgresql || :

if [ "$(id -u)" = '0' ]; then
    find "$PGDATA" \! -user postgres -exec chown postgres '{}' + 2>/dev/null || :
    exec gosu postgres patroni "$@"
fi

exec patroni "$@"
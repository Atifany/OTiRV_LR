#!/bin/bash

# Создаем папку для данных прямо в текущей директории, если её еще нет
mkdir -p ./pgdata

# Запускаем контейнер PostgreSQL
docker run -d \
  --name postgres_db \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=postgres \
  -e POSTGRES_DB=orders_db \
  -p 5432:5432 \
  -v "./pgdata:/var/lib/postgresql/data" \
  -v "./init-scripts:/docker-entrypoint-initdb.d" \
  postgres:16-alpine

echo "Контейнер postgres_db успешно запущен на порту 5432!"
echo "База данных: orders_db"
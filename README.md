# Облачные Технологии и Распределенные Вычисления ЛР4

Для запука etcd кластера:<br>
```docker compose -p etcd-lab -f docker-compose.etcd.yaml up -d```<br>
Проверка контейнеров кластера:<br>
```docker compose -p etcd-lab -f docker-compose.etcd.yaml ps -a```<br>
Проверка здоровья узлов кластера etcd:<br>
```
docker exec etcd1 etcdctl \
  --endpoints=http://etcd1:2379,http://etcd2:2379,http://etcd3:2379 \
  endpoint health
```
Таблица состояния кластера etcd:<br>
```
docker exec etcd1 etcdctl \
  --endpoints=http://etcd1:2379,http://etcd2:2379,http://etcd3:2379 \
  endpoint status -w table
```

Для запуска кластера patroni:<br>
```docker compose -p pg-lab -f docker-compose.patroni.yaml up -d```
Проверка контейнеров кластера:<br>
```docker compose -p pg-lab -f docker-compose.patroni.yaml ps```
Проверка состояния кластера patroni:<br>
```docker exec patroni1 patronictl -c /patroni.yml list```
Просмотр логов при ошибке:<br>
```docker compose -p pg-lab logs patroni2 | tail -60```
Сбросить ключ лидера из etcd:<br>
```docker exec etcd1 etcdctl --endpoints=http://etcd1:2379 del /service/pg-cluster/initialize```

Проверка чтения с базы данных:<br>
```docker exec patroni1 psql -U postgres -d orders_db -c "SELECT * FROM orders;"```
Проверка записи в базу данных (запись только на лидере):<br>
```
docker exec patroni2 psql -U postgres -d orders_db -c \
  "INSERT INTO orders (product_name, price) VALUES ('Makita2470', 15000.00);"
```

Switchover test:<br>
```docker exec patroni1 patronictl -c /patroni.yml switchover --force```
Failover test:<br>
```docker down patroni1```
Скрипт под отдельный терминал читает статус кластера:<br>
```while true; do date +%T; curl -s http://127.0.0.1:7000/ > /dev/null; sleep 1; done```

Для удаления контейнера:<br>
```docker compose down --rmi all```<br>

Для доступа к приложению (настраивается в .env):<br>
```http://localhost:8081/orders```<br>
Для доступа к web-dbeaver (настраивается в .env):<br>
```http://localhost:8082```<br>

Для запроса GET через order-service:
```curl -s http://localhost:8081/orders```
Для проверки POST запроса order-service можно записать новую строку в таблицу через терминал:<br>
```
curl -X POST http://localhost:8081/orders \
     -H "Content-Type: application/json" \
     -d '{"productName": "Makita HP1640", "price": 9000.00}'
```

Для проверки последних 20 строк логов докера (для проверки работы балансировщика прокси):<br>
```docker compose logs --tail=20 order-service```

Кофиги подключений cloudbeaver сохраняются в volume dbeaver_data.<br>
Логи запросов к БД сохраняются в файл /app_logs/database-queries.log<br>
При перезапуске/пересборке контейнера логи сохраняются в volume app_logs.<br>
При перезапуске/пересборке контейнера база данных сохраняется в volume pgdata.
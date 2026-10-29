# Облачные Технологии и Распределенные Вычисления ЛР3

Теория:
etcd — это высоконадежное распределенное хранилище данных формата «ключ-значение» (key-value), разработанное для совместной работы в составе распределенных систем.
Строгая согласованность (Strong Consistency): etcd гарантирует, что все узлы кластера в любой момент времени видят абсолютно одинаковые данные. Если запись подтверждена, она гарантированно доступна для чтения всем клиентам.
Протокол консенсуса Raft: База данных работает на основе алгоритма Raft, который автоматически выбирает лидера среди узлов. Если один или несколько серверов «упадут», система продолжит корректно работать, пока доступно большинство узлов (кворум).

order-service в данной работе не используется.

Для запуска etcd кластера:
```docker compose -p etcd-lab -f docker-compose.etcd.yaml up -d```
Для остановки всего кластера:
```docker compose -p etcd-lab -f docker-compose.etcd.yaml down```
Для удаления volume's:
```docker compose -p etcd-lab -f docker-compose.etcd.yaml down -v```
Проверка состояния контейнера:
```docker compose -p etcd-lab -f docker-compose.etcd.yaml ps -a```
Прямая проверка работоспособности всех контейнеров:
```docker exec etcd1 etcdctl --endpoints=http://etcd1:2379,http://etcd2:2379,http://etcd3:2379 endpoint health```
Посмотреть список узлов:
```docker exec etcd1 etcdctl --endpoints=http://etcd1:2379,http://etcd2:2379,http://etcd3:2379 member list -w table```
Посмотреть статус узлов:
```docker exec etcd1 etcdctl --endpoints=http://etcd1:2379,http://etcd2:2379,http://etcd3:2379 endpoint status -w table```
Сохранение тестовых значений пример с хабра (через символ / записывается префикс ключа):
```
docker exec etcd1 etcdctl --endpoints=http://etcd1:2379,http://etcd2:2379,http://etcd3:2379 put /lab/etcd/cluster "etcd-3-node"
docker exec etcd1 etcdctl --endpoints=http://etcd1:2379,http://etcd2:2379,http://etcd3:2379 put /lab/etcd/leader "etcd3"
docker exec etcd1 etcdctl --endpoints=http://etcd1:2379,http://etcd2:2379,http://etcd3:2379 put /lab/etcd/quorum "2-of-3"
docker exec etcd1 etcdctl --endpoints=http://etcd1:2379,http://etcd2:2379,http://etcd3:2379 put /lab/etcd/test/value "hello-distributed"
```
Просмотр всех данных по префиксу /lab/etcd/:
```docker exec etcd1 etcdctl --endpoints=http://etcd1:2379,http://etcd2:2379,http://etcd3:2379 get /lab/etcd/ --prefix```
Проверка согласованности: читаю одно значение со всех узлов:
```
echo "---";
docker exec etcd1 etcdctl --endpoints=http://127.0.0.1:2379 get /lab/etcd/ --prefix;
echo "---";
docker exec etcd2 etcdctl --endpoints=http://127.0.0.1:2379 get /lab/etcd/ --prefix;
echo "---";
docker exec etcd3 etcdctl --endpoints=http://127.0.0.1:2379 get /lab/etcd/ --prefix;
echo "---";
```
Сценарий добавления 4го узла:
Регистрация нового узла в кластере:
```docker exec etcd1 etcdctl member add etcd4 --peer-urls=http://etcd4:2380```
Включание 4го узла:
```docker compose -p etcd-lab -f docker-compose.etcd.yaml up -d etcd4```
Отключение и удаление 4го узла (Нужен его ID table):
```
docker compose -p etcd-lab -f docker-compose.etcd.yaml rm -sf etcd4
docker volume rm etcd-lab_etcd4-data
docker exec etcd1 etcdctl member remove <ID_etcd4>
```
Теперь проверка здоровья 4х узлов:
```docker exec etcd1 etcdctl --endpoints=http://etcd1:2379,http://etcd2:2379,http://etcd3:2379,http://etcd4:2379 endpoint health```
Проверка лидерства на 4х узлах:
```docker exec etcd2 etcdctl --endpoints=http://etcd1:2379,http://etcd2:2379,http://etcd3:2379,http://etcd4:2379 endpoint status -w table```
Прочитать значения в базе:
```docker exec etcd1 etcdctl get / --prefix```
Отсановка любого узла:
```docker stop etcd1```
Включение любого узла:
```docker start etcd1```




Первый запуск docker compose<br>
```docker compose up -d --build --force-recreate```<br>

Для запуска или остановки контейнера:<br>
```docker compose up -d```<br>
```docker compose down```<br>

Для запуска нескольких реплик order-service (3шт):<br>
```docker compose up -d --scale order-service=3```

Для удаления контейнера:<br>
```docker compose down --rmi all```<br>

Для доступа к приложению (настраивается в .env):<br>
```http://localhost:8081/orders```<br>
Для доступа к web-dbeaver (настраивается в .env):<br>
```http://localhost:8082```<br>

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
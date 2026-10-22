# Облачные Технологии и Распределенные Вычисления ЛР1

Для сборки контейнера postgres необходимо выполнить скрипт запуска контейнера<br>
```./run-postgres.sh```<br>

Для запуска или остановки контейнера:<br>
```docker start postgres_db```<br>
```docker stop postgres_db```<br>

Для удаления контейнера:<br>
```docker rm postgres_db```<br>

Зайти в контейнер базы данных с помощью psql:<br>
```docker exec -it postgres_db psql -U postgres -d orders_db```<br>

Чтобы отобразить существующие таблицы:<br>
```\dt```<br>

Чтобы отобразить содержание таблицы:<br>
```SELECT * FROM orders;```<br>

Чтобы добавить строчку в таблицу:<br>
```INSERT INTO orders (product_name, price) VALUES ('Macbook air 2019 M1', 25000.00);```

Чтобы отобразить содержание таблицы снаружи контейнера необходимо передать в docker exec sql-запрос:<br>
```docker exec postgres_db psql -U postgres -d orders_db -c "SELECT * FROM orders;"```<br>

При перезапуске/пересборке контейнера база данных сохраняется в volume pgdata.<br>
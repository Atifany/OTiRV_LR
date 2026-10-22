# Облачные Технологии и Распределенные Вычисления ЛР2

Первый запуск docker compose<br>
```docker compose up -d --build --force-recreate```<br>

Для запуска или остановки контейнера:<br>
```docker compose up -d```<br>
```docker compose down```<br>

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
     -d '{"productName": "Интерскол ДУ-13/780ЭР", "price": 3790.00}'
```

Кофиги подключений cloudbeaver сохраняются в volume dbeaver_data.<br>
Логи запросов к БД сохраняются в файл /app_logs/database-queries.log<br>
При перезапуске/пересборке контейнера логи сохраняются в volume app_logs.<br>
При перезапуске/пересборке контейнера база данных сохраняется в volume pgdata.
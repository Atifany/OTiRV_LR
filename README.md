# Облачные Технологии и Распределенные Вычисления ЛР1

Первый запуск docker compose<br>
```docker compose up -d --build --force-recreate```<br>

Для запуска или остановки контейнера:<br>
```docker compose up -d```<br>
```docker compose down```<br>

Для удаления контейнера:<br>
```docker compose down --rmi all```<br>

Для проверки работы приложения необходимо перейти по адресу:<br>
```http://localhost:8080/orders```<br>

Логи запросов к БД сохраняются в файл /app_logs/database-queries.log<br>
При перезапуске/пересборке контейнера логи сохраняются в volume app_logs.<br>
При перезапуске/пересборке контейнера база данных сохраняется в volume pgdata.
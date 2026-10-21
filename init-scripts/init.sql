-- Создаю таблицу
CREATE TABLE IF NOT EXISTS orders (
    id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price NUMERIC(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Тестовое первое поле заполняю
INSERT INTO orders (product_name, price) VALUES ('Macbook air 2019 M1', 25000.00);

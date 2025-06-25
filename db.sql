-- Удаление таблиц, если существуют
DROP TABLE IF EXISTS bookings CASCADE;
DROP TABLE IF EXISTS clients CASCADE;
DROP TABLE IF EXISTS rooms CASCADE;

-- Создание таблицы rooms
CREATE TABLE rooms (
    id SERIAL PRIMARY KEY,
    number VARCHAR(50) NOT NULL UNIQUE,
    type VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    capacity INTEGER NOT NULL,
    amenities TEXT[],
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Создание таблицы clients
CREATE TABLE clients (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20),
    is_vip BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Создание таблицы bookings
CREATE TABLE bookings (
    id SERIAL PRIMARY KEY,
    room_id INTEGER NOT NULL REFERENCES rooms(id) ON DELETE CASCADE,
    client_id INTEGER NOT NULL REFERENCES clients(id) ON DELETE CASCADE,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status VARCHAR(20) DEFAULT 'confirmed',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Вставка тестовых данных
INSERT INTO rooms (number, type, price, capacity, amenities) VALUES
('101', 'Standard', 100.00, 2, '{"TV", "WiFi", "Air Conditioning"}'),
('201', 'Deluxe', 200.00, 2, '{"TV", "WiFi", "Air Conditioning", "Mini Bar"}');

INSERT INTO clients (name, email, phone, is_vip) VALUES
('John Doe', 'john@example.com', '+1234567890', false),
('Jane Smith', 'jane@example.com', '+1987654321', true);

INSERT INTO bookings (room_id, client_id, start_date, end_date) VALUES
(1, 1, '2023-07-05', '2023-07-10'),
(2, 2, '2023-07-15', '2023-07-20');
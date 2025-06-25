-- Создание таблицы номеров
CREATE TABLE rooms (
    id SERIAL PRIMARY KEY,
    number VARCHAR(50) NOT NULL UNIQUE,
    type VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    capacity INT NOT NULL,
    amenities TEXT[],
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Создание таблицы клиентов
CREATE TABLE clients (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20),
    is_vip BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Создание таблицы бронирований
CREATE TABLE bookings (
    id SERIAL PRIMARY KEY,
    room_id INT NOT NULL REFERENCES rooms(id),
    client_id INT NOT NULL REFERENCES clients(id),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status VARCHAR(20) DEFAULT 'confirmed',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT no_date_overlap EXCLUDE USING gist (
        room_id WITH =,
        daterange(start_date, end_date) WITH &&
    )
);

-- Тестовые данные
INSERT INTO rooms (number, type, price, capacity, amenities) VALUES
('101', 'Standard', 100.00, 2, '{"TV", "WiFi", "Air Conditioning"}'),
('201', 'Deluxe', 200.00, 2, '{"TV", "WiFi", "Air Conditioning", "Mini Bar"}'),
('301', 'Suite', 350.00, 4, '{"TV", "WiFi", "Air Conditioning", "Mini Bar", "Jacuzzi"}');

INSERT INTO clients (name, email, phone, is_vip) VALUES
('John Doe', 'john.doe@example.com', '+1234567890', FALSE),
('Jane Smith', 'jane.smith@example.com', '+1987654321', TRUE);

-- Создание индексов
CREATE INDEX idx_bookings_room_id ON bookings(room_id);
CREATE INDEX idx_bookings_client_id ON bookings(client_id);
CREATE INDEX idx_bookings_dates ON bookings(start_date, end_date);
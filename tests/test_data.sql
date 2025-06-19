-- Номера в отеле
INSERT INTO rooms (number) VALUES 
('101'), 
('102'), 
('103'), 
('201'), 
('202'), 
('VIP-001'), 
('VIP-002');

-- Бронирования
INSERT INTO bookings (room_id, client_name, is_vip, start_date, end_date) VALUES
-- Стандартные клиенты
(1, 'Alice Johnson', FALSE, '2025-07-01', '2025-07-05'),
(2, 'Bob Smith', FALSE, '2025-07-03', '2025-07-06'),
(3, 'Charlie Brown', FALSE, '2025-07-10', '2025-07-15'),

-- VIP клиенты
(6, 'VIP Diana Prince', TRUE, '2025-07-01', '2025-07-10'),
(7, 'VIP Bruce Wayne', TRUE, '2025-07-05', '2025-07-12'),

-- Перекрывающиеся бронирования на разные номера (разные комнаты)
(4, 'Eve Adams', FALSE, '2025-07-01', '2025-07-05'),
(5, 'Frank Miller', FALSE, '2025-07-04', '2025-07-08');

# Hotel Booking API

## Установка и запуск

1. Установите зависимости:

```bash
pip install -r requirements.txt
```

2. Создайте базу данных PostgreSQL `hotel_booking` и настройте `.env` или `database.py`

3. Выполните инициализацию таблиц:

python3 ->

```python
from app import models, database
models.Base.metadata.create_all(bind=database.engine)
```

4. Добавьте тестовые данные:

```bash
psql hotel_booking < tests/test_data.sql
```

5. Запустите сервер:

```bash
uvicorn app.main:app --reload
```

## Эндпоинты

- GET `/rooms/` — список всех номеров
- GET `/rooms/available/?start=YYYY-MM-DD&end=YYYY-MM-DD` — свободные номера
- POST `/bookings/` — забронировать
- DELETE `/bookings/{booking_id}` — отменить
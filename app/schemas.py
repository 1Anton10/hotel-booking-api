from pydantic import BaseModel
from datetime import date

class Room(BaseModel):
    id: int
    number: str
    model_config = {
        "from_attributes": True
    }

class BookingBase(BaseModel):
    room_id: int
    client_name: str
    start_date: date
    end_date: date

class BookingCreate(BookingBase):
    pass

class Booking(BookingBase):
    id: int
    is_vip: bool
    model_config = {
        "from_attributes": True
    }
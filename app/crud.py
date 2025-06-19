from sqlalchemy.orm import Session
from . import models, schemas
from sqlalchemy import and_
import httpx

async def is_vip(client_name: str) -> bool:
    return client_name.lower().startswith("vip")

def get_all_rooms(db: Session):
    return db.query(models.Room).all()

def get_available_rooms(db: Session, start_date: str, end_date: str):
    subquery = db.query(models.Booking.room_id).filter(
        models.Booking.start_date <= end_date,
        models.Booking.end_date >= start_date
    )
    return db.query(models.Room).filter(~models.Room.id.in_(subquery)).all()

def create_booking(db: Session, booking: schemas.BookingCreate):
    if db.query(models.Booking).filter(
        models.Booking.room_id == booking.room_id,
        models.Booking.start_date <= booking.end_date,
        models.Booking.end_date >= booking.start_date
    ).first():
        raise Exception("Room already booked for this period")
    vip = booking.client_name.lower().startswith("vip")
    db_booking = models.Booking(**booking.dict(), is_vip=vip)
    db.add(db_booking)
    db.commit()
    db.refresh(db_booking)
    return db_booking

def cancel_booking(db: Session, booking_id: int):
    booking = db.query(models.Booking).get(booking_id)
    if not booking:
        raise Exception("Booking not found")
    db.delete(booking)
    db.commit()
    return {"ok": True}
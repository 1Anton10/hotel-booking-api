from fastapi import FastAPI, Depends, HTTPException
from sqlalchemy.orm import Session
from . import models, schemas, crud, database, deps

models.Base.metadata.create_all(bind=database.engine)

app = FastAPI()

@app.get("/rooms/", response_model=list[schemas.Room])
def get_rooms(db: Session = Depends(deps.get_db)):
    return crud.get_all_rooms(db)

@app.get("/rooms/available/", response_model=list[schemas.Room])
def get_available_rooms(start_date: str, end_date: str, db: Session = Depends(deps.get_db)):
    return crud.get_available_rooms(db, start_date, end_date)

@app.post("/bookings/", response_model=schemas.Booking)
def create_booking(booking: schemas.BookingCreate, db: Session = Depends(deps.get_db)):
    return crud.create_booking(db, booking)

@app.delete("/bookings/{booking_id}")
def cancel_booking(booking_id: int, db: Session = Depends(deps.get_db)):
    return crud.cancel_booking(db, booking_id)
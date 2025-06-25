const pool = require('../config/db');
const db = pool.pool

const Booking = {
  create: async (roomId, clientId, startDate, endDate) => {
    const { rows } = await db.query(
      `INSERT INTO bookings (room_id, client_id, start_date, end_date)
       VALUES ($1, $2, $3, $4) RETURNING *`,
      [roomId, clientId, startDate, endDate]
    );
    return rows[0];
  },

  cancel: async (id) => {
    const { rows } = await db.query(
      'DELETE FROM bookings WHERE id = $1 RETURNING *',
      [id]
    );
    return rows[0];
  },

  getById: async (id) => {
    const { rows } = await db.query(
      `SELECT b.*, r.number as room_number, r.type as room_type,
       c.name as client_name, c.email as client_email
       FROM bookings b
       JOIN rooms r ON b.room_id = r.id
       JOIN clients c ON b.client_id = c.id
       WHERE b.id = $1`,
      [id]
    );
    return rows[0];
  },

checkAvailability: async (roomId, startDate, endDate) => {
  const { rows } = await db.query(
    `SELECT b.*, r.number AS room_number, r.type AS room_type,
      c.name AS client_name, c.email AS client_email
     FROM bookings b
     JOIN rooms r ON b.room_id = r.id
     JOIN clients c ON b.client_id = c.id
     WHERE b.start_date = CAST($1 AS DATE)
     AND b.room_id = $2
     AND b.end_date = CAST($3 AS DATE)`,
    [startDate, roomId, endDate]
  );
  console.log(rows)
  return rows[0] ? false : true;
}
};

module.exports = Booking;
const pool = require('../config/db');
const db = pool.pool
const Room = {
  getAll: async () => {
    const { rows } = await db.query('SELECT * FROM rooms ORDER BY id');
    return rows;
  },

  getAvailable: async (startDate, endDate) => {
    const { rows } = await db.query(
      `SELECT r.* FROM rooms r
       WHERE r.id NOT IN (
         SELECT b.room_id FROM bookings b
         WHERE daterange($1::date, $2::date) && daterange(b.start_date, b.end_date)
       )`,
      [startDate, endDate]
    );
    return rows;
  },

  getById: async (id) => {
    const { rows } = await db.query('SELECT * FROM rooms WHERE id = $1', [id]);
    return rows[0];
  }
};

module.exports = Room;
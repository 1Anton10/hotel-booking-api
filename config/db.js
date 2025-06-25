const { Pool } = require('pg');

const pool = new Pool({
  user: 'postgres',
  host: 'localhost',
  database: 'hotel_booking',
  password: '1234',
  port: 5432,
});

async function checkDatabaseSetup() {
  try {
    // Проверяем существование таблиц
    const tables = await pool.query(
      `SELECT table_name 
      FROM information_schema.tables 
      WHERE table_schema = 'public'
      AND table_name IN ('rooms', 'clients', 'bookings')`
    );

    console.log('Существующие таблицы:', tables.rows.map(row => row.table_name));

    // Проверяем, что все необходимые таблицы существуют
    const requiredTables = ['rooms', 'clients', 'bookings'];
    const existingTableNames = tables.rows.map(row => row.table_name);

    // Если не все таблицы найдены, выбрасываем ошибку
    if (requiredTables.some(table => !existingTableNames.includes(table))) {
      throw new Error('Не все таблицы существуют в базе данных');
    }

    console.log('✅ Все необходимые таблицы существуют');
    return true;
  } catch (err) {
    console.error('❌ Ошибка проверки структуры БД:', err.message);
    return false;
  }
}

async function getAvailableRooms(startDate, endDate) {
  try {
    const result = await pool.query(
     ` SELECT r.* FROM rooms r
      WHERE r.id NOT IN (
        SELECT b.room_id FROM bookings b
        WHERE daterange($1::date, $2::date) && daterange(b.start_date, b.end_date)
      )
    `, [startDate, endDate]);

    console.log(`Тест 1 ✅`);
    return result.rows;
  } catch (err) {
    console.error('Ошибка запроса доступных номеров:', err.message);
    throw err;
  }
}

// Проверка работы
(async () => {
  const isReady = await checkDatabaseSetup();
  if (isReady) {
    const availableRooms = await getAvailableRooms('2023-07-01', '2023-07-10');
    console.log(availableRooms.length != 0 ? 'Тест 2 ✅' : 'Тесе 2 ❌' );
  }
})();

module.exports = {
  pool,
  getAvailableRooms
};

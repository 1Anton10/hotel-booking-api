const pool = require('../config/db');
const db = pool.pool

const Client = {
  getById: async (id) => {
    const { rows } = await db.query('SELECT * FROM clients WHERE id = $1', [id]);
    return rows[0];
  },

  checkVipStatus: async (id) => {
    const client = await Client.getById(id);
    if (!client) return null;
      console.log(client)

    const isVip = await client.is_vip;
    
    // Обновляем статус в базе
    await db.query(
      'UPDATE clients SET is_vip = $1 WHERE id = $2',
      [isVip, id]
    );
    
    return isVip;
  }
};

module.exports = Client;
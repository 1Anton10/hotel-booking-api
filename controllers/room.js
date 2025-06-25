const Room = require('../models/room');

const roomController = {
  getAllRooms: async (req, res) => {
    try {
      const rooms = await Room.getAll();
      res.json(rooms);
      console.log(res.json(rooms))
    } catch (err) {
      res.status(500).json({ error: err.message });
    }
  },

  getAvailableRooms: async (req, res) => {
    try {
      const { from, to } = req.query;
      if (!from || !to) {
        return res.status(400).json({ error: 'Both from and to dates are required' });
      }

      const rooms = await Room.getAvailable(from, to);
      res.json(rooms);
    } catch (err) {
      res.status(500).json({ error: err.message });
    }
  },

  getRoomDetails: async (req, res) => {
    try {
      const room = await Room.getById(req.params.id);
      if (!room) {
        return res.status(404).json({ error: 'Room not found' });
      }
      res.json(room);
    } catch (err) {
      res.status(500).json({ error: err.message });
    }
  }
};

module.exports = roomController;
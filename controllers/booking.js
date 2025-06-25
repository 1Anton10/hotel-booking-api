const Booking = require('../models/booking');
const Room = require('../models/room');
const Client = require('../models/client');

const bookingController = {
  createBooking: async (req, res) => {
    try {
      const { roomId, clientId, startDate, endDate } = req.query;

      // Валидация входных данных
      if (!roomId || !clientId || !startDate || !endDate) {
        return res.status(400).json({ error: 'Missing required fields' });
      }

      // Проверяем существование номера
      const room = await Room.getById(roomId);
      if (!room) {
        return res.status(404).json({ error: 'Room not found' });
      }

      // Проверяем существование клиента и получаем его данные
      const client = await Client.getById(clientId);
      if (!client) {
        return res.status(404).json({ error: 'Client not found' });
      }

      // Проверяем доступность номера на указанные даты
      const isAvailable = await Booking.checkAvailability(roomId, startDate, endDate);
      if (!isAvailable) {
        return res.status(409).json({ 
          error: 'Room is already booked for the selected dates',
          roomId,
          conflictingDates: { startDate, endDate }
        });
      }

      // Проверяем VIP-статус (is_vip)
      if (client.is_vip) {
        console.log(`VIP booking for client ${clientId}`);
      }

      // Создаем бронирование
      const booking = await Booking.create(roomId, clientId, startDate, endDate);
      res.status(201).json(booking);

    } catch (err) {
      console.error('Booking error:', err);
      res.status(500).json({ error: err.message });
    }
  },

  cancelBooking: async (req, res) => {
    try {
      const booking = await Booking.cancel(req.params.id);
      if (!booking) {
        return res.status(404).json({ error: 'Booking not found' });
      }
      res.json({ message: 'Booking cancelled successfully', booking });
    } catch (err) {
      res.status(500).json({ error: err.message });
    }
  },

  getBookingDetails: async (req, res) => {
    try {
      const booking = await Booking.getById(req.params.id);
      if (!booking) {
        return res.status(404).json({ error: 'Booking not found' });
      }
      res.json(booking);
    } catch (err) {
      res.status(500).json({ error: err.message });
    }
  },

  // Новый метод для проверки доступности
  checkAvailability: async (req, res) => {
    try {
      const { roomId, startDate, endDate } = req.query;
      const isAvailable = await Booking.checkAvailability(roomId, startDate, endDate);
      res.json({ available: isAvailable });
    } catch (err) {
      res.status(500).json({ error: err.message });
    }
  }
};

module.exports = bookingController;
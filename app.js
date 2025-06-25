const express = require('express');
const bodyParser = require('body-parser');
const roomRoutes = require('./routes/room');
const bookingRoutes = require('./routes/booking');
const clientRoutes = require('./routes/client');

const app = express();

// Мидла
app.use(bodyParser.json());

// Роуты
app.use('/api/rooms', roomRoutes);
app.use('/api/bookings', bookingRoutes);
app.use('/api/clients', clientRoutes);

// Обработка ошибок
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ error: 'Something went wrong!' });
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});

module.exports = app;
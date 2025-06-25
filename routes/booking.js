const express = require('express');
const router = express.Router();
const bookingController = require('../controllers/booking');

router.post('/', bookingController.createBooking);
router.delete('/:id', bookingController.cancelBooking);
router.get('/:id', bookingController.getBookingDetails);

module.exports = router;
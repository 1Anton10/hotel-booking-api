const express = require('express');
const router = express.Router();
const roomController = require('../controllers/room');

router.get('/', roomController.getAllRooms);
router.get('/available', roomController.getAvailableRooms);
router.get('/:id', roomController.getRoomDetails);

module.exports = router;
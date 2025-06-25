const express = require('express');
const router = express.Router();
const clientController = require('../controllers/client');

router.get('/:id/vip-status', clientController.getVipStatus);

module.exports = router;
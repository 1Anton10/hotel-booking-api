const Client = require('../models/client');

const clientController = {
  getVipStatus: async (req, res) => {
    try {
      const isVip = await Client.checkVipStatus(req.params.id);
      if (isVip === null) {
        return res.status(404).json({ error: 'Client not found' });
      }
      res.json({ isVip });
    } catch (err) {
      res.status(500).json({ error: err.message });
    }
  }
};

module.exports = clientController;
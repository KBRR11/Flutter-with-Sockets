

/*
  PATH: /api/mensajes
*/

const { Router } = require('express');
const { obtnerChat } = require('../controllers/mensajes');


const { validarToken } = require('../middlewares/validar-jwt');

const router = Router();

//get Usuarios
router.get('/:de', validarToken ,obtnerChat);




module.exports = router;
/*
Path: /api/usuarios'
*/ 

const { Router } = require('express');
const { getUsuarios } = require('../controllers/usuarios');

const { validarToken } = require('../middlewares/validar-jwt');

const router = Router();

//get Usuarios
router.get('/', validarToken ,getUsuarios);




module.exports = router;
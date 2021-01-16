/*
Path: /api/login'
*/ 

const { Router } = require('express');
const { check } = require('express-validator');
const { crearUsuario } = require('../controllers/auth');
const { validarCampos } = require('../middlewares/validar-campos');

const router = Router();

router.post('/new',[
check('nombre', 'nombre es un campo obligatorio').not().isEmpty(),
check('email', 'email es un campo obligatorio').not().isEmpty(),
check('email', 'email no valido').normalizeEmail().isEmail(),
check('password', 'password es un campo obligatorio').not().isEmpty(),
check('password', 'por lo menos 5 caracteres').isLength({min:5}),
validarCampos
],crearUsuario);


module.exports = router;
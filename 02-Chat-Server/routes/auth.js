/*
Path: /api/login'
*/ 

const { Router } = require('express');
const { check } = require('express-validator');
const { crearUsuario , loginUsuario, renewToken} = require('../controllers/auth');

const { validarCampos } = require('../middlewares/validar-campos');
const { validarToken } = require('../middlewares/validar-jwt');

const router = Router();

//Crear Usuarios
router.post('/new',[
check('nombre', 'nombre es un campo obligatorio').not().isEmpty(),
check('email', 'email es un campo obligatorio').not().isEmpty(),
check('email', 'email no valido').normalizeEmail().isEmail(),
check('password', 'password es un campo obligatorio').not().isEmpty(),
check('password', 'por lo menos 5 caracteres').isLength({min:5}),
validarCampos
],crearUsuario);

//Login Usuarios
router.post('/', [
    check('email', 'email es un campo un obligatorio').not().isEmpty(),
    check('email', 'email no valido').normalizeEmail().isEmail(),
    check('password', 'password es un campo obligatorio').not().isEmpty(),
    
    ], loginUsuario 
    );

router.get('/renewtkn', validarToken ,renewToken);


module.exports = router;
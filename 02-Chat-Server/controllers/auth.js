const { response } = require("express");
const bcrypt = require('bcryptjs');

const Usuario = require("../models/usuario");
const { generarJWT } = require("../helpers/jwt");

//Crear Nuevo Usuario
const crearUsuario = async (req, res = response) => {
  const { email, password } = req.body;

  try {

    const existeEmail = await Usuario.findOne({email});
    if (existeEmail) {
        return res.status(400).json({
            ok: false,
            msg: 'El correo ya fue registrado'
        });
    }
    const usuario = new Usuario(req.body);

    // Encriptar la contraseña
    const salt = bcrypt.genSaltSync();
    usuario.password = bcrypt.hashSync(password, salt);

    await usuario.save();

    //Generar JWT para autenticar nuevo usuario

    const token = await generarJWT(usuario.id, usuario.nombre, usuario.email ); 

    res.json({
      ok: true,
      msg: "USER CREATED!",
      usuario,
      token
    });
  } catch (error) {
    console.log(error);
    res.status(500).json({
      ok: false,
      msg: "Hable con el Administrador!.",
    });
  }
};

//LOGIN

const loginUsuario = async (req, res = response) => {
  const { email, password } = req.body;

  try {

    const usuarioDB = await Usuario.findOne({email});

    if (!usuarioDB) {
      return res.status(404).json({
        ok:false,
        msg: 'Usuario no encontrado'
      });
    }
    //Validar Password
    const validarPassword = bcrypt.compareSync(password, usuarioDB.password);
    if (!validarPassword) {
      return res.status(400).json({
        ok:false,
        msg:'Contraseña invalida'
      });
    }
    //Generar JWT al pasar validaciones
    const token = await generarJWT(usuarioDB.id, usuarioDB.nombre, usuarioDB.email);

    res.json({
      ok: true,
      msg: "USER LOGGED",
      usuario:usuarioDB,
      token
    });

  } catch (error) {
    console.log(error);
    return res.status(500).json({
      ok: true,
      msg: "Hable con el Admin!",
      
    });
  }
  

}

const renewToken = async(req, res=response) => {

const uid = req.uid;

const usuarioTokenRenew = await Usuario.findById(uid);

const token = await generarJWT(usuarioTokenRenew.id, usuarioTokenRenew.nombre, usuarioTokenRenew.email );



     res.json({
       ok:true,
       usuario: usuarioTokenRenew,
       msg: 'Token Renew',
       token: token
     });
}

module.exports = {
  crearUsuario,
  loginUsuario,
  renewToken
};

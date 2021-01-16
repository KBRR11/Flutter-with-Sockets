const { response } = require("express");
const bcrypt = require('bcryptjs');

const Usuario = require("../models/usuario");
const { generarJWT } = require("../helpers/jwt");

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

module.exports = {
  crearUsuario,
};

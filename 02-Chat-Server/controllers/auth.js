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

    const token = await generarJWT(usuario.id, usuario.nombre, usuario.email, usuario.fotoUrl ); 

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
    const token = await generarJWT(usuarioDB.id, usuarioDB.nombre, usuarioDB.email, usuarioDB.fotoUrl);

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


const token = await generarJWT(usuarioTokenRenew.id, usuarioTokenRenew.nombre, usuarioTokenRenew.email , usuarioTokenRenew.fotoUrl);



     res.json({
       ok:true,
       usuario: usuarioTokenRenew,
       msg: 'Token Renew',
       token: token
     });
}

const updatePhoto = async(req, res=response)=>{
  const { uid , fotoUrl} = req.body;
  try{
    const usuariovalidate = await Usuario.findById({_id:uid});
    if (!usuariovalidate) {
      return res.status(404).json({
        ok: false,
        msg: 'Este usuario no fue encontrado o talvez fue eliminado, hable con el administrador'
      });
    }
    
   await Usuario.updateOne({_id:uid}, {fotoUrl});
   const userupd = await Usuario.findOne({fotoUrl});
   const token = await generarJWT(userupd.id, userupd.nombre, userupd.email , userupd.fotoUrl);
   res.json({
    ok: true,
    msg: "Photo Updated",
    usuario: userupd,
    token:token
  });
  }catch{
    console.log(error);
    return res.status(500).json({
      ok: true,
      msg: "Hable con el Admin!",
      
    });
  }
}

module.exports = {
  crearUsuario,
  loginUsuario,
  renewToken,
  updatePhoto
};

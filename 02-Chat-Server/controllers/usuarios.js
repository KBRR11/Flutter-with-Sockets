const { response } = require("express");
const Usuario = require("../models/usuario");


const getUsuarios = async(req, res=response)=>{// obtener usuarios ordenados por Status Online

    const usuarios = await Usuario
        .find({ _id: { $ne: req.uid} })
        .sort('-online') //ordena de manera decendente los valores Booleanos
        //TODO: falta hacer paginaciones
        
        res.json({
            ok: true,
            usuarios
        });



};

module.exports = {
    getUsuarios
};
const jwt = require('jsonwebtoken');

const validarToken = (req, res, next) => {
    //leer token
    const token = req.header('x-token');
    

    if( !token ){
    return res.status(401).json({
        ok: false,
        msg: 'No hay token'
    });
    }

    try {
        const { uid , nombre, email} = jwt.verify( token, process.env.JWT_KEY);
        req.uid    = uid;
        req.nombre = nombre;
        req.email  = email;
       
        next();
    } catch (error) {
        return res.status(401).json({
            ok:false,
            msg: 'Token no válido'
        });
    }
}


module.exports = {
    validarToken
}
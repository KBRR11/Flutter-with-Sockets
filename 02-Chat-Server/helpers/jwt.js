const jwt = require("jsonwebtoken");

const generarJWT = (uid, nombre, email) => {
  return new Promise((resolve, reject) => {
    const payload = {
      uid,
      nombre,
      email,
    };

    jwt.sign(
      payload,
      process.env.JWT_KEY,
      {
        expiresIn: "24h",
      },
      (err, token) => {
        if (err) {
          /// algo salio mal
          reject('no se pudo generar JWT');
        } else {
          // retornar token
          resolve( token );
        }
      }
    );
  });
};

module.exports = {
  generarJWT,
};

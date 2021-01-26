const jwt = require("jsonwebtoken");

const generarJWT = (uid, nombre, email, fotoUrl) => {
  return new Promise((resolve, reject) => {
    const payload = {
      uid,
      nombre,
      email,
      fotoUrl
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
          resolve(token);
        }
      }
    );
  });
};

const comprobarJWT = (token = '') => {
  try {
    const { uid } = jwt.verify(token, process.env.JWT_KEY);
    return [true, uid];
  } catch (error) {
     return [false, null];
  }
};

module.exports = {
  generarJWT,
  comprobarJWT
};

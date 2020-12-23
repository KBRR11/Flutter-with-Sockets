const express = require('express');
const path = require('path');
require('dotenv').config();


//App de Express
const app = express();

//Node Server Socket.io
const server = require('http').createServer(app);
module.exports.io = require('socket.io')(server);

require('./sockets/socket');

//path público
const publicPath = path.resolve(__dirname, 'public');

app.use( express.static(publicPath));

server.listen(process.env.PORT, (err)=>{
  
    if(err) throw new Error(err);

    console.log('Servidor corriendo en el puerto', process.env.PORT);
});